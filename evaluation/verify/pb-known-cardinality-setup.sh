#!/usr/bin/env bash
# Introspection SETUP: set paragraph_blocks max_cardinality to a distinctive 7. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set paragraph_blocks.settings max_cardinality 7 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: paragraph_blocks.settings max_cardinality = 7"
