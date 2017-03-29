#!/usr/bin/env bash
set -euxo pipefail
apt update
apt install python -y
adduser manager --disabled-password -q
echo "manager ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
sudo -u manager bash -c "mkdir ~/.ssh"
cp /root/.ssh/authorized_keys /home/manager/.ssh/authorized_keys
chown manager:manager /home/manager/.ssh/authorized_keys
