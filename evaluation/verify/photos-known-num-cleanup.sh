#!/usr/bin/env bash
# Introspection CLEANUP: restore photos.settings:photos_num to its shipped default (5). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("photos.settings")->set("photos_num", 5)->save();' >/dev/null 2>&1
echo "cleanup: photos.settings:photos_num = 5 (default)"
