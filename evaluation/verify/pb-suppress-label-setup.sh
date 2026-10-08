#!/usr/bin/env bash
# Introspection SETUP: turn suppress_label ON. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set paragraph_blocks.settings suppress_label 1 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: paragraph_blocks.settings suppress_label = true"
