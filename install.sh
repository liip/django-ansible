#!/usr/bin/env bash
mkdir deployment

if [ $1 = "local" ]; then
    ln -s ../`dirname $0` deployment/django-ansible
else
    git submodule add https://github.com/liip/django-ansible.git deployment/django-ansible
fi

mkdir deployment/group_vars
cp deployment/django-ansible/dist/group_vars/all deployment/group_vars/all
cp deployment/django-ansible/dist/group_vars/production deployment/group_vars/production
cp deployment/django-ansible/dist/ansible.cfg deployment/ansible.cfg
cp deployment/django-ansible/dist/production deployment/production
cp deployment/django-ansible/dist/site.yml deployment/site.yml

cd deployment
./django-ansible/scripts/check_venv.sh
cd ..

echo -e "\ndeployment/venv/" >> .gitignore

ln -s django-ansible/scripts/setup.sh deployment/setup.sh
ln -s django-ansible/scripts/deploy.sh deployment/deploy.sh

echo
echo "----------------------------------------------------"
echo "We are done! Now update the config files for your setup:"
echo "* deployment/group_vars/all        # global project configuration"
echo "* deployment/group_vars/production # system specific configuration"
echo "* deployment/production            # adjust server ip address"
echo ""
echo "After that, go to the deployment directory and run ./setup.sh production to setup your server."
echo "As long as you do not change any of the ansible settings, you can use the ./deploy.sh script"
echo "to deploy your code changes (it's much faster than ./setup.sh)"
