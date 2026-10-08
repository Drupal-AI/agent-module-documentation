#!/usr/bin/env bash
# Execution RESET (device_geolocation H2): restore shipped default use_ajax_check=false so verify FAILS
# on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("device_geolocation.settings")->set("use_ajax_check", FALSE)->save();' >/dev/null 2>&1
echo "reset: device_geolocation.settings:use_ajax_check = false"
