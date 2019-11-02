#!/bin/bash

set -xe

APP=verctl
LOCATION=westeurope
STORAGE_KEY=$( az storage account keys list -g $APP \
    --account-name $APP --query "[0].value" --output tsv )

az container show -g $APP -n $APP -o none