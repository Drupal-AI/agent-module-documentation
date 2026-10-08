#!/usr/bin/env bash
# Execution RESET: (re)create an EMPTY table dbal_task2 so verify FAILS until the agent inserts a
# row with note='dbal-done' through the dbal Doctrine DBAL connection. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush sql:query "DROP TABLE IF EXISTS dbal_task2" >/dev/null 2>&1
drush sql:query "CREATE TABLE dbal_task2 (id INT, note VARCHAR(64))" >/dev/null 2>&1
echo "reset: empty table dbal_task2 created"
