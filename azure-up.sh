#!/bin/bash

APP=verctl
LOCATION=westeurope

# Create a resource group
az group create -l $LOCATION -n $APP

# Create a storage account
az storage account create \
    -g $APP \
    -l $LOCATION \
    --kind StorageV2 \
    --sku Standard_LRS \
    -n $APP