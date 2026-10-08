#!/usr/bin/env bash
# Execution CLEANUP (smart_ip_ip2location_bin_db H): restore shipped default caching_method=no_cache. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset smart_ip_ip2location_bin_db.settings caching_method no_cache -y >/dev/null 2>&1
echo "cleanup: smart_ip_ip2location_bin_db.settings:caching_method restored to no_cache"
