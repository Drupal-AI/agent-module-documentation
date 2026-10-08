#!/usr/bin/env bash
# Execution RESET: clear the MaxMind license key so verify FAILS until the agent sets it.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("visitors_geoip.settings")->set("license", "")->save();' >/dev/null 2>&1
echo "reset: visitors_geoip.settings license='' (empty)"
