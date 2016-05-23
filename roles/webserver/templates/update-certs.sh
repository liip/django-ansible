#!/usr/bin/env bash
letsencrypt certonly --webroot --webroot-path /tmp/letsencrypt -d {{ domain }} {% if use_www %}-d www.{{ domain }}{% endif %}
sudo systemctl reload nginx
