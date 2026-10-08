#!/usr/bin/env bash
# Execution RESET (smart_ip_ip2location_bin_db H): restore shipped default caching_method=no_cache
# so verify FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset smart_ip_ip2location_bin_db.settings caching_method no_cache -y >/dev/null 2>&1
echo "reset: smart_ip_ip2location_bin_db.settings:caching_method = no_cache"
