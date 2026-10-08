#!/usr/bin/env bash
# Introspection CLEANUP: clear the pixel id (shipped default is an empty string). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("facebook_pixel.settings")->set("facebook_id", "")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: facebook_pixel.settings facebook_id cleared"
