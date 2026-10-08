#!/usr/bin/env bash
# Introspection SETUP: create table dbal_probe with a known label value so an agent can read it
# back through the dbal Doctrine DBAL connection. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush sql:query "DROP TABLE IF EXISTS dbal_probe" >/dev/null 2>&1
drush sql:query "CREATE TABLE dbal_probe (id INT, label VARCHAR(64))" >/dev/null 2>&1
drush sql:query "INSERT INTO dbal_probe (id, label) VALUES (1, 'dbal-secret-42')" >/dev/null 2>&1
echo "setup: table dbal_probe row id=1 label=dbal-secret-42"
