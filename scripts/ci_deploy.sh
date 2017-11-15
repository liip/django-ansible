#!/usr/bin/env bash
set -euxo pipefail

# install nodejs
curl -sL https://deb.nodesource.com/setup_8.x | bash -
apt-get install nodejs -y
npm install -g yarn

# setup ssh access to servers
eval $(ssh-agent -s)
ssh-add <(echo "$SSH_PRIVATE_KEY")
mkdir -p ~/.ssh
echo -e "Host *\n\tStrictHostKeyChecking no\n\n" > ~/.ssh/config

# run the deployment
cd ./deployment/
./deploy.sh $1
