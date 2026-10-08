#!/usr/bin/env bash
# Introspection CLEANUP: restore photos.settings:photos_cover_imagesize default (thumbnail). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("photos.settings")->set("photos_cover_imagesize", "thumbnail")->save();' >/dev/null 2>&1
echo "cleanup: photos.settings:photos_cover_imagesize = thumbnail (default)"
