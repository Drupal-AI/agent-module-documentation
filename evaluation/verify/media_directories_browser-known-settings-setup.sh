#!/usr/bin/env bash
# Introspection SETUP: write a distinctive, known media_directories_browser.settings state so
# an inspecting agent can read it back from the live site. The matching cleanup restores the
# module's shipped config/install defaults for exactly these keys. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  \Drupal::configFactory()->getEditable("media_directories_browser.settings")
    ->set("page_size", 37)
    ->set("directory_sort", "weight")
    ->set("show_directory_counts", TRUE)
    ->set("enable_bulk_actions", TRUE)
    ->set("embed_image_styles", ["thumbnail", "large"])
    ->save();
' >/dev/null 2>&1

echo "setup: media_directories_browser.settings page_size=37 directory_sort=weight counts=on bulk=on embed_image_styles=[thumbnail,large]"
