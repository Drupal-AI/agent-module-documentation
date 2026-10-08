#!/usr/bin/env bash
# Introspection CLEANUP: restore max_cardinality shipped default (10). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set paragraph_blocks.settings max_cardinality 10 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: paragraph_blocks.settings max_cardinality = 10"
