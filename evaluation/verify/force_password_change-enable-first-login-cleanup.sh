#!/usr/bin/env bash
# Execution CLEANUP: restore shipped default (FALSE). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset force_password_change.settings first_time_login_password_change 0 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: first_time_login_password_change=0"
