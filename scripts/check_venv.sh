#!/usr/bin/env bash
if [ ! -d "venv" ]; then
    virtualenv -p python3 venv/
    venv/bin/pip install -U pip
    venv/bin/pip install ansible
fi
