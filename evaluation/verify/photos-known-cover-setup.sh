#!/usr/bin/env bash
# Introspection SETUP: set photos.settings:photos_cover_imagesize to a known style (medium) so an
# agent can read which image style album covers use. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("photos.settings")->set("photos_cover_imagesize", "medium")->save();' >/dev/null 2>&1
echo "setup: photos.settings:photos_cover_imagesize = medium"
