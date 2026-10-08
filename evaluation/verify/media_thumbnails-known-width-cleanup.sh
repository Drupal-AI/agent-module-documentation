#!/usr/bin/env bash
# Introspection CLEANUP: restore the module's shipped defaults.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("media_thumbnails.settings")
    ->set("width", 500)
    ->set("bgcolor_active", FALSE)
    ->set("bgcolor_value", "#eeeeee")
    ->set("no_thumbnail_update", FALSE)
    ->set("allow_thumbnail_edit", FALSE)
    ->save();
' >/dev/null 2>&1
echo "cleanup: media_thumbnails.settings restored to shipped defaults"
