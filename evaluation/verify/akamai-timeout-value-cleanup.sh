#!/usr/bin/env bash
# Introspection CLEANUP: restore akamai timeout to shipped default (5). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set akamai.settings timeout 5 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: akamai.settings timeout = 5"
