#!/bin/sh

ACR_RESOURCE_GROUP_NAME="sc-resource-group"
ACR_NAME="scimagesacr"

# Create a resource group to store container registry
az group create --name $ACR_RESOURCE_GROUP_NAME --location westeurope

# Create a container registry that will be where you deploy your image to
az acr create --resource-group $ACR_RESOURCE_GROUP_NAME --name $ACR_NAME --sku Basic