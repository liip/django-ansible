#!/usr/bin/env bash
if [ ! -d "venv" ]; then
    virtualenv -p python2 venv/
    venv/bin/pip install ansible~=2.1.1.0
fi
