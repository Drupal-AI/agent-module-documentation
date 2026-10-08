#!/usr/bin/env bash
# Execution CLEANUP (device_geolocation H2): restore shipped default use_ajax_check=false. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("device_geolocation.settings")->set("use_ajax_check", FALSE)->save();' >/dev/null 2>&1
echo "cleanup: device_geolocation.settings:use_ajax_check restored to false"
