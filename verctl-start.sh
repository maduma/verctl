#!/bin/bash

set -e

APP=verctl
STORAGE_KEY=$( az storage account keys list -g $APP \
    --account-name $APP --query "[0].value" --output tsv )

az container show -g $APP -n $APP -o none 2>/dev/null && {
    echo "AlreadyRunning"
    exit 0
}

az container create \
    -g $APP \
    -n $APP \
    -l westeurope \
    --image gitlab/gitlab-ce \
    --dns-name-label $APP \
    --ports 22 80 443 \
    --azure-file-volume-account-name $APP \
    --azure-file-volume-account-key $STORAGE_KEY \
    --azure-file-volume-share-name $APP \
    --azure-file-volume-mount-path /var/opt/gitlab

FQDN=$( az container show \
    -g $APP -n $APP --query "ipAddress.fqdn" -o tsv )

echo "Application $APP started."
echo "FQDN: $FQDN"