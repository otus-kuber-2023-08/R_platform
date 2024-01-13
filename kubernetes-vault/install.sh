helm upgrade --install consul oci://registry-1.docker.io/bitnamicharts/consul
helm upgrade --install vault oci://registry-1.docker.io/bitnamicharts/vault --values values.yaml
