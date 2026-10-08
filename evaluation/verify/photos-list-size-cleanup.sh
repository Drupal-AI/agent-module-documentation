#!/usr/bin/env bash
# Execution CLEANUP: restore photos.settings:photos_display_list_imagesize default (large). Exit 0.
# verify FAILS until the agent changes it to thumbnail. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("photos.settings")->set("photos_display_list_imagesize", "large")->save();' >/dev/null 2>&1
echo "cleanup: photos.settings:photos_display_list_imagesize = large"
