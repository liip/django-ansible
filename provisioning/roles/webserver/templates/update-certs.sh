#!/usr/bin/env bash
mkdir -p /tmp/letsencrypt/
letsencrypt certonly --webroot --webroot-path /tmp/letsencrypt -d {{ domain }} {% if use_www %}-d www.{{ domain }}{% endif %} --keep-until-expiring -n
sudo systemctl reload nginx
