#!/usr/bin/env bash
./django-ansible/scripts/check_venv.sh
venv/bin/ansible-playbook -s site.yml -i hosts
