#!/bin/bash

# delete all azure resource

set -ex

APP=verctl
LOCATION=westeurope

az storage share delete -n $APP --account-name $APP
az storage account delete -g $APP -n $APP --yes
az group delete -n $APP --yes