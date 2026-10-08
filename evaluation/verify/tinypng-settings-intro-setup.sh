#!/usr/bin/env bash
# Introspection SETUP: set tinypng.settings to a known non-default configuration (compress on
# upload, download method) so an agent can read the live config. Uses a placeholder api key so
# no real TinyPNG API is ever called. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("tinypng.settings")
    ->set("api_key", "PLACEHOLDER_INTROSPECT_KEY")
    ->set("on_upload", TRUE)
    ->set("upload_method", "download")
    ->set("image_action", TRUE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: tinypng.settings on_upload=1 upload_method=download"
