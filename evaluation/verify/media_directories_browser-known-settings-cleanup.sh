#!/usr/bin/env bash
# Introspection CLEANUP: restore the media_directories_browser.settings keys touched by the
# matching setup to the module's shipped config/install defaults
# (page_size 100, directory_sort alphabetical, counts off, bulk off, no embed image styles).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  \Drupal::configFactory()->getEditable("media_directories_browser.settings")
    ->set("page_size", 100)
    ->set("directory_sort", "alphabetical")
    ->set("show_directory_counts", FALSE)
    ->set("enable_bulk_actions", FALSE)
    ->set("embed_image_styles", [])
    ->save();
' >/dev/null 2>&1

echo "cleanup: media_directories_browser.settings restored to shipped defaults"
