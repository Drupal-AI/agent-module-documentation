#!/usr/bin/env bash
# Execution RESET: set photos.settings:photos_display_list_imagesize to its default (large) so
# verify FAILS until the agent changes it to thumbnail. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("photos.settings")->set("photos_display_list_imagesize", "large")->save();' >/dev/null 2>&1
echo "reset: photos.settings:photos_display_list_imagesize = large"
