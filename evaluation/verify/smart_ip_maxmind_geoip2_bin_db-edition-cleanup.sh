#!/usr/bin/env bash
# Introspection CLEANUP (smart_ip_maxmind_geoip2_bin_db M): restore shipped default edition city. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset smart_ip_maxmind_geoip2_bin_db.settings edition city -y >/dev/null 2>&1
echo "cleanup: smart_ip_maxmind_geoip2_bin_db.settings:edition restored to city"
