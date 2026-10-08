#!/usr/bin/env bash
# Introspection CLEANUP: restore tinypng.settings shipped defaults explicitly (api_key '',
# on_upload 0, upload_method 'upload', image_action 1). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("tinypng.settings")
    ->set("api_key", "")
    ->set("on_upload", 0)
    ->set("upload_method", "upload")
    ->set("image_action", 1)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: tinypng.settings restored to defaults"
