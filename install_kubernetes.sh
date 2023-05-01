#!/bin/bash

#Installing Kubernetes
KUBERNETES_INSTALLED=$(which kubeadm)
if [ "$KUBERNETES_INSTALLED" = "" ]
then
        curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
        touch /etc/apt/sources.list.d/kubernetes.list
        chmod 666 /etc/apt/sources.list.d/kubernetes.list
        echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list
        apt-get update
        # apt-get install -y kubelet kubeadm kubectl kubernetes-cni
        apt-get install -qy kubelet=1.23.6-00 kubeadm=1.23.6-00 kubectl=1.23.6-00 kubernetes-cni
fi

#Disabling swap for Kubernetes
sysctl net.bridge.bridge-nf-call-iptables=1 > /dev/null
swapoff -a
