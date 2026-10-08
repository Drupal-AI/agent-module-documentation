#!/usr/bin/env bash
# Introspection CLEANUP: restore geoip_path to the shipped default '../'.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("visitors_geoip.settings")->set("geoip_path", "../")->save();' >/dev/null 2>&1
echo "cleanup: visitors_geoip.settings geoip_path=../"
