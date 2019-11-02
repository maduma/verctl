#!/bin/bash

set -xe

function error {
    echo "$@"
    exit 1
}

APP=verctl
STORAGE_KEY=$( az storage account keys list -g $APP \
    --account-name $APP --query "[0].value" --output tsv )

az container show -g $APP -n $APP -o none 2>/dev/null && \
    error "Container $APP already running!"

az container create \
    -g $APP \
    -n $APP \
    -l westeurope \
    --image httpd \
    --dns-name-label $APP \
    --ports 80 \
    --azure-file-volume-account-name $APP \
    --azure-file-volume-account-key $STORAGE_KEY \
    --azure-file-volume-share-name $APP \
    --azure-file-volume-mount-path /usr/local/apache2/htdocs/