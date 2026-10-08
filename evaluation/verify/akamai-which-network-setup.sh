#!/usr/bin/env bash
# Introspection SETUP: point the akamai purge network at STAGING. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set akamai.settings domain.production 0 -y >/dev/null 2>&1
drush config:set akamai.settings domain.staging 1 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: akamai.settings domain = staging"
