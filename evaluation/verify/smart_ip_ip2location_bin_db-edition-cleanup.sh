#!/usr/bin/env bash
# Introspection CLEANUP (smart_ip_ip2location_bin_db M): restore shipped default edition DB11. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset smart_ip_ip2location_bin_db.settings edition DB11 -y >/dev/null 2>&1
echo "cleanup: smart_ip_ip2location_bin_db.settings:edition restored to DB11"
