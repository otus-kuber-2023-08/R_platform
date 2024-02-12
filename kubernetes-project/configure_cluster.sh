#!/bin/bash


kubectl apply -f https://raw.githubusercontent.com/yandex-cloud/k8s-csi-s3/master/deploy/kubernetes/csi-s3.yaml
kubectl apply -f https://raw.githubusercontent.com/yandex-cloud/k8s-csi-s3/master/deploy/kubernetes/driver.yaml
kubectl apply -f https://raw.githubusercontent.com/yandex-cloud/k8s-csi-s3/master/deploy/kubernetes/provisioner.yaml

cd terraform
export ACCESS_KEY=$(terraform output -json static-key-access-key | jq -j ".")
#echo $ACCESS_KEY
sed -i "s/accessKeyID: .*/accessKeyID: \"$ACCESS_KEY\"/g" ../config/csi.yml
export SECRET_KEY=$(terraform output -json static-key-secret-key | jq -j ".")
#echo $SECRET_KEY
sed -i "s/secretAccessKey: .*/secretAccessKey: \"$SECRET_KEY\"/g" ../config/csi.yml
cd ..
kubectl apply -f config/
# Example https://github.com/stevesea/argocd-helm-app-of-apps-example/blob/master/README.md

# Get latest kube config
#cat kubespray/inventory/sample/artifacts/admin.conf > ~/.kube/config

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
# cat inventory/sample/artifacts/admin.conf | grep server | sed 's/server: https:\/\///g' | sed 's/:6443//g' | sed 's/ //g'
#export HOST_URL=$(cat inventory/sample/artifacts/admin.conf | grep server | sed 's/server: https:\/\///g' | sed 's/:6443//g' | sed 's/ //g')
#echo $HOST_URL argocd.local prometheus.local grafana.local | sudo tee -a /etc/hosts