#!/usr/bin/env bash
# Introspection SETUP: set the SVG thumbnail output width (media_thumbnails.settings.width) to
# a known value 640. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("media_thumbnails.settings")->set("width",640)->save();' >/dev/null 2>&1
echo "setup: media_thumbnails.settings width=640"
