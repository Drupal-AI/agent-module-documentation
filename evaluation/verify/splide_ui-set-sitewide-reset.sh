#!/usr/bin/env bash
# Execution RESET: set splide.settings sitewide=0 so verify FAILS until the agent turns it on. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("splide.settings")->set("sitewide",0)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: splide.settings sitewide=0"
