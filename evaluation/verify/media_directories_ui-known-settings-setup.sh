#!/usr/bin/env bash
# Introspection SETUP: write a known media_directories_ui.settings state (both media-library
# tabs hidden, admin toolbar links hidden, combined upload on for image+document) so an
# inspecting agent can read it back from the live site. The matching cleanup restores the
# module's shipped config/install defaults. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  \Drupal::configFactory()->getEditable("media_directories_ui.settings")
    ->set("hide_media_library_media_tab", TRUE)
    ->set("hide_media_library_files_tab", TRUE)
    ->set("hide_admin_toolbar_links", TRUE)
    ->set("enable_combined_upload", TRUE)
    ->set("combined_upload_media_types", ["image", "document"])
    ->save();
' >/dev/null 2>&1

echo "setup: media_directories_ui.settings tabs+toolbar hidden, combined upload on for [image, document]"
