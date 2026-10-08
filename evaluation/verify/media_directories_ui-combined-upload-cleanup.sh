#!/usr/bin/env bash
# Execution CLEANUP for "enable combined upload in the deprecated UI submodule".
# Clears enable_combined_upload / combined_upload_media_types in media_directories_ui.settings
# so the site is left clean. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  \Drupal::configFactory()->getEditable("media_directories_ui.settings")
    ->set("enable_combined_upload", FALSE)
    ->set("combined_upload_media_types", [])
    ->save();
' >/dev/null 2>&1

echo "cleanup: media_directories_ui combined upload off, no media types"
