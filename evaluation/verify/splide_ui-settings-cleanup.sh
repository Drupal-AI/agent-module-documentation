#!/usr/bin/env bash
# Restore shipped default sitewide=0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("splide.settings")->set("sitewide",0)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: splide.settings sitewide=0 (default)"
