#!/usr/bin/env bash
# Execution RESET: (re)create role migsui_task WITHOUT the access permission so verify FAILS
# until the agent grants it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush role:delete migsui_task >/dev/null 2>&1 || true
drush role:create migsui_task "Migsui Task" >/dev/null 2>&1 || true
echo "reset: role migsui_task created without 'access migrate source ui'"
