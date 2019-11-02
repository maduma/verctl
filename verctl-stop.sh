#!/bin/bash

set -xe

function error {
    echo "$@"
    exit 1
}

APP=verctl

az container show -g $APP -n $APP -o none 2>/dev/null || \
    error "Container $APP do not exists!"

az container delete -g $APP -n $APP -y