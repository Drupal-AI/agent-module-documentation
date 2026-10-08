#!/usr/bin/env bash
# Execution RESET: force akamai network back to production so verify FAILS until switched. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set akamai.settings domain.staging 0 -y >/dev/null 2>&1
drush config:set akamai.settings domain.production 1 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: akamai.settings domain = production"
