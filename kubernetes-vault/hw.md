```shell

helm install --name=vault .
helm status vault

NAME: vault
LAST DEPLOYED: Sat Jan 13 16:53:49 2024
NAMESPACE: default
STATUS: deployed
REVISION: 1
NOTES:
Thank you for installing HashiCorp Vault!

Now that you have deployed Vault, you should look over the docs on using
Vault with Kubernetes available here:

https://developer.hashicorp.com/vault/docs


Your release is named vault. To learn more about the release, try:

  $ helm status vault
  $ helm get manifest vault 
```
========================================================================================  
```shell
kubectl logs vault-0
WARNING! Unable to read storage migration status.
2024-01-13T13:55:51.413Z [INFO]  proxy environment: http_proxy="" https_proxy="" no_proxy=""
2024-01-13T13:55:51.413Z [WARN]  storage.consul: appending trailing forward slash to path
2024-01-13T13:55:51.414Z [WARN]  storage migration check error: error="Get \"http://172.18.0.8:8500/v1/kv/vault/core/migration\": dial tcp 172.18.0.8:8500: connect: connection refused"
```

```text
kubectl exec -it vault-0 -- vault operator init --key-shares=1 --key-threshold=1
Unseal Key 1: yB8p2Mu5nAWdlCy4Uwi2UWqBXTC+kKb/YUKxqZcGE20=

Initial Root Token: hvs.9bRhNAn0jcV63gYvKjoc02P0

Vault initialized with 1 key shares and a key threshold of 1. Please securely
distribute the key shares printed above. When the Vault is re-sealed,
restarted, or stopped, you must supply at least 1 of these keys to unseal it
before it can start servicing requests.

Vault does not store the generated root key. Without at least 1 keys to
reconstruct the root key, Vault will remain permanently sealed!

It is possible to generate new unseal keys, provided you have a quorum of
existing unseal keys shares. See "vault operator rekey" for more information.

```

```text
kubectl exec -it vault-0 -- vault status
---                -----
Seal Type          shamir
Initialized        true
Sealed             true
Total Shares       1
Threshold          1
Unseal Progress    0/1
Unseal Nonce       n/a
Version            1.15.2
Build Date         2023-11-06T11:33:28Z
Storage Type       consul
HA Enabled         true[0m
```

```text
kubectl exec -it vault-0 -- vault operator unseal
Unseal Key (will be hidden): 
Key             Value
---             -----
Seal Type       shamir
Initialized     true
Sealed          false
Total Shares    1
Threshold       1
Version         1.15.2
Build Date      2023-11-06T11:33:28Z
Storage Type    consul
Cluster Name    vault-cluster-3a48e431
Cluster ID      39596831-e396-4b3f-5188-ff5e5febf9c8
HA Enabled      true
HA Cluster      https://vault-0.vault-internal:8201
HA Mode         active
Active Since    2024-01-13T14:05:51.775096318Z

kubectl exec -it vault-1 -- vault operator unseal
Unseal Key (will be hidden): 
Key                    Value
---                    -----
Seal Type              shamir
Initialized            true
Sealed                 false
Total Shares           1
Threshold              1
Version                1.15.2
Build Date             2023-11-06T11:33:28Z
Storage Type           consul
Cluster Name           vault-cluster-3a48e431
Cluster ID             39596831-e396-4b3f-5188-ff5e5febf9c8
HA Enabled             true
HA Cluster             https://vault-0.vault-internal:8201
HA Mode                standby
Active Node Address    http://10.244.5.6:8200
rmazitov@DESKTOP-4KG5NL1 ~/I/R/kubernetes-vaul

kubectl exec -it vault-2 -- vault operator unseal
Unseal Key (will be hidden): 
Key                    Value
---                    -----
Seal Type              shamir
Initialized            true
Sealed                 false
Total Shares           1
Threshold              1
Version                1.15.2
Build Date             2023-11-06T11:33:28Z
Storage Type           consul
Cluster Name           vault-cluster-3a48e431
Cluster ID             39596831-e396-4b3f-5188-ff5e5febf9c8
HA Enabled             true
HA Cluster             https://vault-0.vault-internal:8201
HA Mode                standby
Active Node Address    http://10.244.5.6:8200
```

### Status
```text
kubectl exec -it vault-0 -- vault status
[0mKey             Value
---             -----
Seal Type       shamir
Initialized     true
Sealed          false
Total Shares    1
Threshold       1
Version         1.15.2
Build Date      2023-11-06T11:33:28Z
Storage Type    consul
Cluster Name    vault-cluster-3a48e431
Cluster ID      39596831-e396-4b3f-5188-ff5e5febf9c8
HA Enabled      true
HA Cluster      https://vault-0.vault-internal:8201
HA Mode         active
Active Since    2024-01-13T14:05:51.775096318Z[0m

kubectl exec -it vault-1 -- vault status
[0mKey                    Value
---                    -----
Seal Type              shamir
Initialized            true
Sealed                 false
Total Shares           1
Threshold              1
Version                1.15.2
Build Date             2023-11-06T11:33:28Z
Storage Type           consul
Cluster Name           vault-cluster-3a48e431
Cluster ID             39596831-e396-4b3f-5188-ff5e5febf9c8
HA Enabled             true
HA Cluster             https://vault-0.vault-internal:8201
HA Mode                standby
Active Node Address    http://10.244.5.6:8200[0m

kubectl exec -it vault-2 -- vault status
[0mKey                    Value
---                    -----
Seal Type              shamir
Initialized            true
Sealed                 false
Total Shares           1
Threshold              1
Version                1.15.2
Build Date             2023-11-06T11:33:28Z
Storage Type           consul
Cluster Name           vault-cluster-3a48e431
Cluster ID             39596831-e396-4b3f-5188-ff5e5febf9c8
HA Enabled             true
HA Cluster             https://vault-0.vault-internal:8201
HA Mode                standby
Active Node Address    http://10.244.5.6:8200[0m
```

```text
kubectl exec -it vault-0 -- vault login

Token (will be hidden): 
Success! You are now authenticated. The token information displayed below
is already stored in the token helper. You do NOT need to run "vault login"
again. Future Vault requests will automatically use this token.

Key                  Value
---                  -----
token                hvs.9bRhNAn0jcV63gYvKjoc02P0
token_accessor       wwXQpHoe873slUIJFhmNeBce
token_duration       ∞
token_renewable      false
token_policies       ["root"]
identity_policies    []
policies             ["root"]
```

```text
kubectl exec -it vault-0 -- vault auth list
Path      Type     Accessor               Description                Version
----      ----     --------               -----------                -------
token/    token    auth_token_cf7e35df    token based credentials    n/a
```

```text
/ $ vault read otus/otus-ro/config
Key                 Value
---                 -----
refresh_interval    768h
password            asajkjkahs
username            otus
/ $ 

```

```text
/ $ vault auth enable kubernetes
Success! Enabled kubernetes auth method at: kubernetes/
/ $ vault auth list
Path           Type          Accessor                    Description                Version
----           ----          --------                    -----------                -------
kubernetes/    kubernetes    auth_kubernetes_2c38511a    n/a                        n/a
token/         token         auth_token_cf7e35df         token based credentials    n/a
/ $ 

```