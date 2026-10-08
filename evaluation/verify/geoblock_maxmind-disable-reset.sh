#!/usr/bin/env bash
# Execution RESET: set a non-empty download_url so verify (passes only when it is empty) FAILS
# until the agent clears it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("geoblock_maxmind.settings")->set("download_url","https://old.example.com/GeoLite2-Country.tar.gz")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: geoblock_maxmind.settings download_url set to a non-empty URL"
