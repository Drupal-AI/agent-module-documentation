#!/usr/bin/env bash
# Introspection SETUP: switch on the two thumbnail-protection booleans with a distinctive width
# so the agent has to inspect the live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("media_thumbnails.settings")
    ->set("width", 640)
    ->set("bgcolor_active", FALSE)
    ->set("bgcolor_value", "#eeeeee")
    ->set("no_thumbnail_update", TRUE)
    ->set("allow_thumbnail_edit", TRUE)
    ->save();
' >/dev/null 2>&1
echo "setup: media_thumbnails.settings no_thumbnail_update=TRUE allow_thumbnail_edit=TRUE width=640"
