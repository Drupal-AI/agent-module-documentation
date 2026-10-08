#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped defaults (both FALSE). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset force_password_change.settings first_time_login_password_change 0 -y >/dev/null 2>&1
drush cset force_password_change.settings check_login_only 0 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: force_password_change.settings restored (first_time_login_password_change=0 check_login_only=0)"
