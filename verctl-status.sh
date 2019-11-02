#!/bin/bash

set -e

APP=verctl

function is_container_exists {
    az container show -g $APP -n $APP -o none 2>/dev/null 
}

function container_state {
    az container show -g verctl -n verctl \
    --query "containers[0].instanceView.currentState.state" \
    -o tsv
}

function container_fqdn {
    az container show -g $APP -n $APP \
    --query "ipAddress.fqdn" -o tsv
}

is_container_exists || {
    echo "NoContainer"
    exit 0
}
container_state
container_fqdn