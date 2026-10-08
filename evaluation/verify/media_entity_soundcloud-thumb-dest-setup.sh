#!/usr/bin/env bash
# Introspection SETUP: set a known SoundCloud thumbnail destination so the agent can read it
# back from media_entity_soundcloud.settings. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("media_entity_soundcloud.settings")
    ->set("thumbnail_destination", "public://mes_probe_thumbs")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: thumbnail_destination=public://mes_probe_thumbs"
