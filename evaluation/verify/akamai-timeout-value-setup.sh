#!/usr/bin/env bash
# Introspection SETUP: set akamai API timeout to a distinctive 17 seconds. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set akamai.settings timeout 17 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: akamai.settings timeout = 17"
