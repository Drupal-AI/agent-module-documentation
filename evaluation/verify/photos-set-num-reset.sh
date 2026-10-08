#!/usr/bin/env bash
# Execution RESET: set photos.settings:photos_num to its default (5) so verify FAILS until the
# agent changes the upload form to show 8 slots. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("photos.settings")->set("photos_num", 5)->save();' >/dev/null 2>&1
echo "reset: photos.settings:photos_num = 5"
