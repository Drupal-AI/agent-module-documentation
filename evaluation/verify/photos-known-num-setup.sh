#!/usr/bin/env bash
# Introspection SETUP: set photos.settings:photos_num to a known value (12) so an agent can read
# back how many upload slots the upload form shows. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("photos.settings")->set("photos_num", 12)->save();' >/dev/null 2>&1
echo "setup: photos.settings:photos_num = 12"
