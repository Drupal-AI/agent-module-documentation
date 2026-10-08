#!/usr/bin/env bash
# Introspection SETUP (device_geolocation M1): set a known geolocation-check frequency (10800s = 3h)
# so the agent must read the live config to report it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("device_geolocation.settings")->set("frequency_check", 10800)->save();' >/dev/null 2>&1
echo "setup: device_geolocation.settings:frequency_check = 10800 (3 hours)"
