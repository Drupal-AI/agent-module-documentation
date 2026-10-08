#!/usr/bin/env bash
# Introspection SETUP: set a known MaxMind download URL in geoblock_maxmind.settings so an
# inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("geoblock_maxmind.settings")
    ->set("download_url", "https://mirror.example.org/geoip/GeoLite2-Country-known.tar.gz")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: geoblock_maxmind.settings download_url set to the known mirror URL"
