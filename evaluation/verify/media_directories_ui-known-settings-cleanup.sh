#!/usr/bin/env bash
# Introspection CLEANUP: restore media_directories_ui.settings to the module's shipped
# config/install defaults (everything false / empty). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  \Drupal::configFactory()->getEditable("media_directories_ui.settings")
    ->set("hide_media_library_media_tab", FALSE)
    ->set("hide_media_library_files_tab", FALSE)
    ->set("hide_admin_toolbar_links", FALSE)
    ->set("enable_combined_upload", FALSE)
    ->set("combined_upload_media_types", [])
    ->save();
' >/dev/null 2>&1

echo "cleanup: media_directories_ui.settings restored to shipped defaults"
