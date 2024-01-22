#!/bin/bash

# TODO make it from argoCD
# ArgoCD examples https://github.com/argoproj/argocd-example-apps

cat kubespray/inventory/sample/artifacts/admin.conf > ~/.kube/config

kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/v0.0.26/deploy/local-path-storage.yaml

echo 'Installing EFK'
# ElasticSearch
helm upgrade --install -n observability --create-namespace elasticsearch bitnami/elasticsearch -f manifests/elastic-values.yml
# Kibana
# Fluent Bit

echo 'Installing Jaeger'
helm repo add jaegertracing https://jaegertracing.github.io/helm-charts
helm upgrade --install jaeger-tracing jaegertracing/jaeger -n observability -f manifests/jaeger-values.yml

echo 'Installing harbor'
# https://github.com/goharbor/harbor-helm/blob/main/values.yaml
helm repo add harbor https://helm.goharbor.io
helm upgrade --install harbor harbor/harbor -n registry --create-namespace -f manifests/harbor-values.yml

#echo 'Installing vault'
# install from previous hw

# install argo
helm upgrade --install -n argo --create-namespace argo bitnami/argo-cd -f manifests/argocd-values.yml
kubectl apply -f manifests/argo
