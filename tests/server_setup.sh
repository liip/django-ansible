#!/usr/bin/env bash
set -euxo pipefail
useradd manager -m -s /bin/bash
echo "manager ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
sudo -u manager bash -c "mkdir /home/manager/.ssh"
cp /root/.ssh/authorized_keys /home/manager/.ssh/authorized_keys
chown manager:manager /home/manager/.ssh/authorized_keys
apt update
apt install python -y
