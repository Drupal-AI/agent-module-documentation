#!/usr/bin/env bash
# Execution RESET: force geoip_path to '../' so verify FAILS until the agent sets the target path.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("visitors_geoip.settings")->set("geoip_path", "../")->save();' >/dev/null 2>&1
echo "reset: visitors_geoip.settings geoip_path=../"
