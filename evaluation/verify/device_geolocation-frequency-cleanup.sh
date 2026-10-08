#!/usr/bin/env bash
# Introspection CLEANUP (device_geolocation M1): restore shipped default frequency_check=null (disabled). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("device_geolocation.settings")->set("frequency_check", NULL)->save();' >/dev/null 2>&1
echo "cleanup: device_geolocation.settings:frequency_check restored to null"
