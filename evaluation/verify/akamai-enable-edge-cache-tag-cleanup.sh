#!/usr/bin/env bash
# Execution CLEANUP: restore edge_cache_tag_header to baseline FALSE. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set akamai.settings edge_cache_tag_header 0 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: akamai.settings edge_cache_tag_header = FALSE"
