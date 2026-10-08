#!/usr/bin/env bash
# Introspection SETUP: seed the State key that schedules the next MaxMind DB auto-update.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->set("geoblock_maxmind.update_date", 1893456000);' >/dev/null 2>&1
echo "setup: State geoblock_maxmind.update_date = 1893456000"
