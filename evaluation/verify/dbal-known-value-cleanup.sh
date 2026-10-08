#!/usr/bin/env bash
# Introspection CLEANUP: drop the dbal_probe table. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush sql:query "DROP TABLE IF EXISTS dbal_probe" >/dev/null 2>&1
echo "cleanup: table dbal_probe dropped"
