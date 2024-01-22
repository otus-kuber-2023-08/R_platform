#!/bin/bash

# Get latest kube config
cat kubespray/inventory/sample/artifacts/admin.conf > ~/.kube/config

# Create local path CSI
kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/v0.0.26/deploy/local-path-storage.yaml

# install argo
helm upgrade --install -n argo --create-namespace argo bitnami/argo-cd --set global.storageClass=local-path
# Configure argo
kubectl apply -f manifests
