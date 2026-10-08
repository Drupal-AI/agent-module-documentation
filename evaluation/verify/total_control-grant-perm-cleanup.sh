#!/usr/bin/env bash
# Execution CLEANUP: delete role tc_task. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush role:delete tc_task >/dev/null 2>&1 || true
drush cr >/dev/null 2>&1
echo "cleanup: tc_task removed"
