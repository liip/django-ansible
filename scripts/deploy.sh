#!/usr/bin/env bash
venv/bin/ansible-playbook -s site.yml -i hosts --tags deploy
