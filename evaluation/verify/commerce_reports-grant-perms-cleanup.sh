#!/usr/bin/env bash
# Execution CLEANUP: delete the creports_analyst role, restoring baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush role:delete creports_analyst >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: role creports_analyst deleted"
