#!/usr/bin/env bash
# Introspection SETUP: set splide.settings sitewide=1 so an agent can read back the current setting. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("splide.settings")->set("sitewide",1)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: splide.settings sitewide=1"
