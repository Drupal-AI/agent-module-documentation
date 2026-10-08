#!/usr/bin/env bash
# Introspection SETUP (smart_ip M1): configure a known data source so the agent must read the
# live smart_ip config to report it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset smart_ip.settings data_source maxmind_geoip2_bin_db -y >/dev/null 2>&1
echo "setup: smart_ip.settings:data_source = maxmind_geoip2_bin_db"
