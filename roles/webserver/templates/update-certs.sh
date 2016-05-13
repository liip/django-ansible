#!/usr/bin/env bash
letsencrypt certonly --webroot --webroot-path /tmp/letsencrypt -d {{ domain }} -d www.{{ domain }}
sudo systemctl reload nginx
