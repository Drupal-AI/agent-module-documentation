#!/usr/bin/env bash
# Execution CLEANUP: delete the migsui_task role (restores baseline). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush role:delete migsui_task >/dev/null 2>&1 || true
echo "cleanup: role migsui_task deleted"
