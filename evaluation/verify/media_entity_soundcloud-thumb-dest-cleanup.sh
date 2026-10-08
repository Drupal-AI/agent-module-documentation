#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped default thumbnail_destination. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("media_entity_soundcloud.settings")
    ->set("thumbnail_destination", "public://soundcloud")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: thumbnail_destination restored to public://soundcloud"
