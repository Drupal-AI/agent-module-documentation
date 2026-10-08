#!/usr/bin/env bash
# Execution RESET: ensure role creports_analyst exists WITHOUT the two commerce_reports
# permissions so verify FAILS until granted. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush role:create creports_analyst 'Commerce Reports Analyst' >/dev/null 2>&1
drush role:perm:remove creports_analyst 'access commerce reports' >/dev/null 2>&1
drush role:perm:remove creports_analyst 'generate commerce order reports' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: role creports_analyst present without commerce_reports permissions"
