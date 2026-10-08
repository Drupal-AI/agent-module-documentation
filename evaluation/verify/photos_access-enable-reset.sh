#!/usr/bin/env bash
# Execution RESET: force album privacy OFF (photos.settings:photos_access_photos = 0) so verify
# FAILS until the agent enables it for the photos album type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("photos.settings")->set("photos_access_photos", 0)->save();' >/dev/null 2>&1
echo "reset: photos.settings:photos_access_photos = 0"
