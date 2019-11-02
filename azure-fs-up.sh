#!/bin/bash

# create all azure resource needed for container with
# data on file share

set -xe

APP=verctl
LOCATION=westeurope

function is_group_exists {
    az group show --name $APP -o none 2>/dev/null
}

function is_storage_exists {
    az storage account show --name $APP -o none 2>/dev/null
}

function is_share_exists {
    az storage share show -n verctl --account-name verctl \
    -o none 2>/dev/null
}

# Create a resource group
is_group_exists || az group create -l $LOCATION -n $APP

# Create a storage account
is_storage_exists || az storage account create \
--kind StorageV2 --sku Standard_LRS -g $APP -l $LOCATION -n $APP

# Create the file share
is_share_exists || az storage share create \
--account-name $APP -n $APP