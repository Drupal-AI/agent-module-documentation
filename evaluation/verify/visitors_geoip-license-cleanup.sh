#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("visitors_geoip.settings")->set("license", "")->save();' >/dev/null 2>&1
echo "cleanup: visitors_geoip.settings license='' (empty)"
