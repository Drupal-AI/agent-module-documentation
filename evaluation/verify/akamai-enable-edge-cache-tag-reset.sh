#!/usr/bin/env bash
# Execution RESET: force edge_cache_tag_header OFF so verify FAILS until enabled. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set akamai.settings edge_cache_tag_header 0 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: akamai.settings edge_cache_tag_header = FALSE"
