#!/bin/bash

set -xe

APP=verctl
LOCATION=westeurope

# Create a resource group
az group show --name $APP -o none 2>/dev/null || \
az group create -l $LOCATION -n $APP

# Create a storage account
az storage account show --name $APP -o none 2>/dev/null || \
az storage account create \
    -g $APP \
    -l $LOCATION \
    --kind StorageV2 \
    --sku Standard_LRS \
    -n $APP

# Create the file share
az storage share show -n verctl --account-name verctl \
    -o none 2>/dev/null || \
az storage share create --account-name $APP -n $APP

# Get the storage access key
STORAGE_KEY=$( az storage account keys list -g $APP \
    --account-name $APP --query "[0].value" --output tsv )
echo $STORAGE_KEY