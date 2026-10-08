#!/usr/bin/env bash
# Introspection SETUP (smart_ip_ip2location_bin_db M): set a known product edition so the agent
# must read the live config to report it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset smart_ip_ip2location_bin_db.settings edition DB3 -y >/dev/null 2>&1
echo "setup: smart_ip_ip2location_bin_db.settings:edition = DB3"
