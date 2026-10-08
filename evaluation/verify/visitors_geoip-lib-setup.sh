#!/usr/bin/env bash
# Introspection SETUP: ensure visitors_geoip is enabled so the agent can inspect the live geoip
# library availability via the visitors_geoip.lookup service. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx visitors_geoip || drush en visitors_geoip -y >/dev/null 2>&1
echo "setup: visitors_geoip enabled (visitors_geoip.lookup service available)"
