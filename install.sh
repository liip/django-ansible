#!/usr/bin/env bash
mkdir deployment
git submodule add https://github.com/liip/django-ansible.git deployment/django-ansible

mkdir deployment/group_vars
cp deployment/django-ansible/dist/group_vars/all deployment/group_vars/all
cp deployment/django-ansible/dist/ansible.cfg deployment/ansible.cfg
cp deployment/django-ansible/dist/hosts deployment/hosts
cp deployment/django-ansible/dist/site.yml deployment/site.yml

virtualenv -p python2 deployment/venv/
deployment/venv/bin/pip install ansible~=2.1.1.0
echo "deployment/venv/" >> .gitignore

ln -s django-ansible/scripts/setup.sh deployment/setup.sh
ln -s django-ansible/scripts/deploy.sh deployment/deploy.sh

echo
echo "----------------------------------------------------"
echo "We are done! Now replace all TODOs in the files in deployment/group_vars/all, deployment/site.yml and deployment/hosts"
echo "After that, go to the deployment directory and run ./setup.sh to setup your server."
echo "As long as you do not change any of the ansible settings, you can use the ./deploy.sh script"
echo "to deploy your code changes (it's much faster than ./setup.sh)"
