#!/usr/bin/env bash
# Introspection SETUP (smart_ip_maxmind_geoip2_bin_db M): set a known edition (country) so the agent
# must read the live config to report it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset smart_ip_maxmind_geoip2_bin_db.settings edition country -y >/dev/null 2>&1
echo "setup: smart_ip_maxmind_geoip2_bin_db.settings:edition = country"
