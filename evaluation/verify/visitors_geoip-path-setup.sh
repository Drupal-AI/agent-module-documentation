#!/usr/bin/env bash
# Introspection SETUP: set a distinctive geoip_path on visitors_geoip.settings so the agent can
# read it back. Baseline is '../'. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("visitors_geoip.settings")->set("geoip_path", "/vgeoip/db/GeoLite2-City.mmdb")->save();' >/dev/null 2>&1
echo "setup: visitors_geoip.settings geoip_path=/vgeoip/db/GeoLite2-City.mmdb"
