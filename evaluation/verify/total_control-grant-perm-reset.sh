#!/usr/bin/env bash
# Execution RESET: create role tc_task WITHOUT 'have total control' so verify FAILS until the
# agent grants it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush role:create tc_task "TC Task" >/dev/null 2>&1 || true
drush role:perm:remove tc_task 'have total control' >/dev/null 2>&1 || true
drush cr >/dev/null 2>&1
echo "reset: role tc_task exists without 'have total control'"
