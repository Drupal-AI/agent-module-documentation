#!/usr/bin/env bash
# Execution RESET: force max_cardinality back to 10 so verify FAILS until set to 20. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set paragraph_blocks.settings max_cardinality 10 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: paragraph_blocks.settings max_cardinality = 10"
