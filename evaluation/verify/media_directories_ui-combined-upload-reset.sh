#!/usr/bin/env bash
# Execution RESET for "enable combined upload in the deprecated UI submodule".
# Clears enable_combined_upload / combined_upload_media_types in media_directories_ui.settings
# so verify FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  \Drupal::configFactory()->getEditable("media_directories_ui.settings")
    ->set("enable_combined_upload", FALSE)
    ->set("combined_upload_media_types", [])
    ->save();
' >/dev/null 2>&1

echo "reset: media_directories_ui combined upload off, no media types"
