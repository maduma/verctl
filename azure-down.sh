#!/bin/bash

set -ex

APP=verctl
LOCATION=westeurope

az storage account delete -g $APP -n $APP --yes
az group delete -n $APP --yes