#!/usr/bin/env bash
# Execution RESET: turn the restriction OFF (disabled=1, user 1 editable) so verify FAILS until the
# agent re-enables the protection. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset disable_user_1_edit.settings disabled 1 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: disabled=1 (user 1 currently editable)"
