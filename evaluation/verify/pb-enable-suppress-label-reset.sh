#!/usr/bin/env bash
# Execution RESET: force suppress_label OFF so verify FAILS until enabled. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set paragraph_blocks.settings suppress_label 0 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: paragraph_blocks.settings suppress_label = false"
