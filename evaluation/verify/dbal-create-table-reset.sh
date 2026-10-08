#!/usr/bin/env bash
# Execution RESET: drop table dbal_task so verify FAILS until the agent creates it (with a row)
# through the dbal Doctrine DBAL connection. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush sql:query "DROP TABLE IF EXISTS dbal_task" >/dev/null 2>&1
echo "reset: table dbal_task dropped"
