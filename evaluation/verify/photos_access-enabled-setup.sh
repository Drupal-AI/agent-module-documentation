#!/usr/bin/env bash
# Introspection SETUP: turn ON album privacy for the 'photos' album type by setting
# photos.settings:photos_access_photos = 1, so an agent can read whether privacy is active.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("photos.settings")->set("photos_access_photos", 1)->save();' >/dev/null 2>&1
echo "setup: photos.settings:photos_access_photos = 1 (album privacy ON for photos)"
