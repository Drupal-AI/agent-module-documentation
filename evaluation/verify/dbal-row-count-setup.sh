#!/usr/bin/env bash
# Introspection SETUP: create table dbal_probe_rows with exactly 3 rows so an agent can count
# them through the dbal Doctrine DBAL connection. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush sql:query "DROP TABLE IF EXISTS dbal_probe_rows" >/dev/null 2>&1
drush sql:query "CREATE TABLE dbal_probe_rows (id INT)" >/dev/null 2>&1
drush sql:query "INSERT INTO dbal_probe_rows (id) VALUES (1),(2),(3)" >/dev/null 2>&1
echo "setup: table dbal_probe_rows has 3 rows"
