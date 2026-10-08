#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped default width (500). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("media_thumbnails.settings")->set("width", 500)->save();' >/dev/null 2>&1
echo "cleanup: media_thumbnails.settings width restored to 500"
