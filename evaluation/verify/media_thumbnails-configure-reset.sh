#!/usr/bin/env bash
# Execution RESET: force media_thumbnails.settings back to values the task does not want, so
# verify fails until the agent changes them. Idempotent. Exit 0.
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
echo "reset: media_thumbnails.settings back to shipped defaults (width=500, bgcolor off)"
