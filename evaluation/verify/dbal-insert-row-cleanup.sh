#!/usr/bin/env bash
# Execution CLEANUP: drop table dbal_task2. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush sql:query "DROP TABLE IF EXISTS dbal_task2" >/dev/null 2>&1
echo "cleanup: table dbal_task2 dropped"
