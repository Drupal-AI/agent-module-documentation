#!/usr/bin/env bash
# Execution CLEANUP: delete role menu_select_navigator. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush role:delete menu_select_navigator >/dev/null 2>&1 || true
echo "cleanup: role menu_select_navigator removed"
