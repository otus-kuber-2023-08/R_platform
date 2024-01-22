#!/bin/bash

set -e

cd terraform
TF_IN_AUTOMATION=1 terraform init
TF_IN_AUTOMATION=1 terraform apply -auto-approve
bash generate_inventory.sh > ../kubespray_inventory/hosts.ini
bash generate_credentials_velero.sh > ../kubespray_inventory/credentials-velero
bash generate_etc_hosts.sh > ../kubespray_inventory/etc-hosts

cd ../
rm -rf kubespray/inventory/mycluster
mkdir -p kubespray/inventory
cp -rfp kubespray_inventory kubespray/inventory/mycluster

export ANSIBLE_HOST_KEY_CHECKING=False
#ansible-playbook -i kubespray/inventory/mycluster/hosts.ini --key-file=/home/rmazitov/.ssh/id_rsa

cd kubespray
ansible-playbook -i inventory/mycluster/hosts.ini --become --become-user=root  --key-file=/home/rmazitov/.ssh/id_rsa  cluster.yml

cd ../terraform
MASTER_1_PRIVATE_IP=$(terraform output -json instance_group_masters_private_ips | jq -j ".[0]")
MASTER_1_PUBLIC_IP=$(terraform output -json instance_group_masters_public_ips | jq -j ".[0]")
sed -i -- "s/$MASTER_1_PRIVATE_IP/$MASTER_1_PUBLIC_IP/g" ../kubespray/inventory/mycluster/artifacts/admin.conf