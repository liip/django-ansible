#!/usr/bin/env bash
./django-ansible/scripts/check_venv.sh

if [ -z "$1" ]; then
    if [ -f ./hosts ]; then
        HOSTS=hosts
    else
        echo "usage: $0 <system>"
        exit
    fi
else
    HOSTS=$1
fi

venv/bin/ansible-playbook  -i $HOSTS --tags deploy site.yml
