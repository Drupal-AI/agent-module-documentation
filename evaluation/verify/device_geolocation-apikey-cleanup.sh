#!/usr/bin/env bash
# Introspection CLEANUP (device_geolocation M2): restore shipped default google_map_api_key=null. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("device_geolocation.settings")->set("google_map_api_key", NULL)->save();' >/dev/null 2>&1
echo "cleanup: device_geolocation.settings:google_map_api_key restored to null"
