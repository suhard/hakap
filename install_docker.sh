#!/bin/bash

apt-get update
apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-get install -y docker-ce

sed 's/^ExecStart.*/& --mtu=1450/' -i /lib/systemd/system/docker.service
cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"]
}
EOF
mkdir ~/.docker
cat <<EOF | sudo tee ~/.docker/config.json
{
  "mtu": 1450
}
EOF

systemctl daemon-reload
service docker restart
