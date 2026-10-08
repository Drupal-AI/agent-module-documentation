#!/usr/bin/env bash
# Execution RESET: (re)create role fs3_task WITHOUT the 'use S3 CORS upload' permission so verify
# FAILS until the agent grants it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush role:create fs3_task >/dev/null 2>&1 || true
drush role:perm:remove fs3_task 'use S3 CORS upload' >/dev/null 2>&1 || true
echo "reset: role fs3_task exists without 'use S3 CORS upload'"
