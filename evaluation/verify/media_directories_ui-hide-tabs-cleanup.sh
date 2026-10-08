#!/usr/bin/env bash
# Execution CLEANUP for "hide the core Media/Files tabs with the deprecated UI submodule".
# Restores media_directories_ui.settings to shipped defaults so the site is left clean.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  \Drupal::configFactory()->getEditable("media_directories_ui.settings")
    ->set("hide_media_library_media_tab", FALSE)
    ->set("hide_media_library_files_tab", FALSE)
    ->set("hide_admin_toolbar_links", FALSE)
    ->save();
' >/dev/null 2>&1

echo "cleanup: media_directories_ui tab/toolbar hiding switched off"
