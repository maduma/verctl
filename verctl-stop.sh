#!/bin/bash

set -e

APP=verctl

az container show -g $APP -n $APP -o none 2>/dev/null || {
    echo NoContainer
    exit 0
}

az container delete -g $APP -n $APP -y

echo "Application $APP stopped."