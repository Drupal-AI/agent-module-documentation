#!/usr/bin/env bash
# Execution CLEANUP: restore akamai network to production baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set akamai.settings domain.staging 0 -y >/dev/null 2>&1
drush config:set akamai.settings domain.production 1 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: akamai.settings domain = production"
