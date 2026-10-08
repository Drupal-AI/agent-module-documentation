#!/usr/bin/env bash
# Execution RESET: ensure role menu_select_navigator does NOT exist, so verify FAILS until the
# agent creates it and grants the permission. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush role:delete menu_select_navigator >/dev/null 2>&1 || true
echo "reset: role menu_select_navigator absent"
