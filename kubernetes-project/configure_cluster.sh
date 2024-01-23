#!/bin/bash

# Example https://github.com/stevesea/argocd-helm-app-of-apps-example/blob/master/README.md

# Get latest kube config
cat kubespray/inventory/sample/artifacts/admin.conf > ~/.kube/config

# Create local path CSI
kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/v0.0.26/deploy/local-path-storage.yaml

# install argo
helm upgrade --install -n argo --create-namespace argo bitnami/argo-cd --set global.storageClass=local-path
# Configure argo
kubectl apply -f manifests

#export vault_conf=$(kubectl -n infra exec -it vault-server-0 -- vault operator init --key-shares=1 --key-threshold=1)

#echo $vault_conf

#unseal_key=$(echo $vault_conf | grep Unseal | sed 's/Unseal Key 1: //g')
#root_key=$(echo $vault_conf | grep Root | sed 's/Root Token //g')

# todo make this for each vault
#kubectl -n infra exec -it vault-server-0 -- vault operator unseal $unseal_key

# todo set initial root Toeken here
#kubectl -n infra exec -it vault-server-0 -- vault login
#$(root_key)