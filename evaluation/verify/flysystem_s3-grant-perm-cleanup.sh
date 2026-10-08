#!/usr/bin/env bash
# Execution CLEANUP: delete role fs3_task. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush role:delete fs3_task >/dev/null 2>&1 || true
echo "cleanup: role fs3_task removed"
