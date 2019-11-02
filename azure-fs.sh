#!/bin/bash

# create/destroy all azure resource needed for file share

set -e

APP=verctl
LOCATION=westeurope

function is_group_exists {
    az group show --name $APP -o none 2>/dev/null
}

function is_storage_exists {
    az storage account show --name $APP -o none 2>/dev/null
}

function is_share_exists {
    az storage share show -n verctl --account-name verctl  -o none 2>/dev/null
}

function create_azure_resources {
    # Create a resource group
    is_group_exists || az group create -l $LOCATION -n $APP

    # Create a storage account
    is_storage_exists || az storage account create \
    --kind StorageV2 --sku Standard_LRS -g $APP -l $LOCATION -n $APP

    # Create the file share
    is_share_exists || az storage share create --account-name $APP -n $APP
}

function delete_azure_resources {
    is_share_exists && az storage share delete -n $APP --account-name $APP
    is_storage_exists && az storage account delete -g $APP -n $APP --yes
    is_group_exists && az group delete -n $APP --yes
}

case $1 in
    up)
        create_azure_resources
        ;;
    down)
        delete_azure_resources
        ;;
    *)
        echo "Usage: $( basename $0 ) up|down"
        ;;
esac