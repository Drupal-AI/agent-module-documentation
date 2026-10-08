#!/usr/bin/env bash
# Introspection CLEANUP: turn album privacy back OFF (photos_access_photos = 0), the default. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("photos.settings")->set("photos_access_photos", 0)->save();' >/dev/null 2>&1
echo "cleanup: photos.settings:photos_access_photos = 0 (default)"
