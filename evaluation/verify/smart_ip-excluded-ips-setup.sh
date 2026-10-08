#!/usr/bin/env bash
# Introspection SETUP (smart_ip M2): set a known excluded IP so the agent must read the live
# smart_ip config to report which IP is skipped from geolocation. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush cset smart_ip.settings excluded_ips "203.0.113.42" -y >/dev/null 2>&1
echo "setup: smart_ip.settings:excluded_ips = 203.0.113.42"
