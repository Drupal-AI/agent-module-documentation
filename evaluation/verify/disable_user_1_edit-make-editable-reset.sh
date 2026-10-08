#!/usr/bin/env bash
# Execution RESET: ensure the restriction is ON (disabled=0, user 1 locked) so verify FAILS until the
# agent makes user 1 editable. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset disable_user_1_edit.settings disabled 0 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: disabled=0 (user 1 currently locked)"
