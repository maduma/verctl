#!/bin/bash

set -e

URL=https://verctl.madum.org/
APP=verctl

az container show -g $APP -n $APP -o none 2>/dev/null && {
    echo "AlreadyRunning"
    exit 0
}

STORAGE_KEY=$( az storage account keys list -g $APP \
    --account-name $APP --query "[0].value" --output tsv )

az container create \
    -g $APP \
    -n $APP \
    -l westeurope \
    --image gitlab/gitlab-ce:12.3.6-ce.0 \
    --dns-name-label $APP \
    --ports 22 80 443 \
    --cpu 2 \
    --memory 4 \
    --environment-variables \
        GITLAB_OMNIBUS_CONFIG="external_url '$URL';" \
    --azure-file-volume-account-name $APP \
    --azure-file-volume-account-key $STORAGE_KEY \
    --azure-file-volume-share-name $APP \
    --azure-file-volume-mount-path /var/opt/gitlab

FQDN=$( az container show \
    -g $APP -n $APP --query "ipAddress.fqdn" -o tsv )

echo "Application $APP started."
echo "FQDN: $FQDN"