#!/bin/bash

set -xe

function error {
    echo "$@"
    exit 1
}

APP=verctl
LOCATION=westeurope
STORAGE_KEY=$( az storage account keys list -g $APP \
    --account-name $APP --query "[0].value" --output tsv )

az container show -g $APP -n $APP -o none 2>/dev/null || \
error "Container $APP already running!"