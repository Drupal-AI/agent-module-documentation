#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("visitors_geoip.settings")->set("geoip_path", "../")->save();' >/dev/null 2>&1
echo "cleanup: visitors_geoip.settings geoip_path=../"
