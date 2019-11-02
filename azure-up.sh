#!/bin/bash

set -v

APP=verctl
LOCATION=westeurope

# Create a resource group
az group show --name $APP -o none 2>/dev/null || \
az group create -l $LOCATION -n $APP

# Create a storage account
az storage acount show --name $APP -o none 2>/dev/null || \
az storage account create \
    -g $APP \
    -l $LOCATION \
    --kind StorageV2 \
    --sku Standard_LRS \
    -n $APP