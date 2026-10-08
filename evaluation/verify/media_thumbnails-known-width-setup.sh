#!/usr/bin/env bash
# Introspection SETUP: write a known media_thumbnails configuration so the agent must read the
# live config to answer. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("media_thumbnails.settings")
    ->set("width", 321)
    ->set("bgcolor_active", TRUE)
    ->set("bgcolor_value", "#abcdef")
    ->set("no_thumbnail_update", FALSE)
    ->set("allow_thumbnail_edit", FALSE)
    ->save();
' >/dev/null 2>&1
echo "setup: media_thumbnails.settings width=321 bgcolor_active=TRUE bgcolor_value=#abcdef"
