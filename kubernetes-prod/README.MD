Развернут кластер из 3 мастеров и 2 воркеров. Развернуто все на локальной тачке на виртуальных машинах. Виртуальные машины предварительно запущены с Vagrant.

Приложен inventory.ini файл для Kubespray.

```text
ansible@node1:~$ kubectl get nodes -o wide
NAME    STATUS   ROLES           AGE     VERSION   INTERNAL-IP     EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION     CONTAINER-RUNTIME
node1   Ready    control-plane   4m      v1.28.5   192.168.56.10   <none>        Ubuntu 20.04.1 LTS   5.4.0-42-generic   containerd://1.7.11
node2   Ready    control-plane   3m45s   v1.28.5   192.168.56.11   <none>        Ubuntu 20.04.1 LTS   5.4.0-42-generic   containerd://1.7.11
node3   Ready    control-plane   3m42s   v1.28.5   192.168.56.12   <none>        Ubuntu 20.04.1 LTS   5.4.0-42-generic   containerd://1.7.11
node4   Ready    <none>          3m10s   v1.28.5   192.168.56.20   <none>        Ubuntu 20.04.1 LTS   5.4.0-42-generic   containerd://1.7.11
node5   Ready    <none>          3m10s   v1.28.5   192.168.56.21   <none>        Ubuntu 20.04.1 LTS   5.4.0-42-generic   containerd://1.7.11
```
