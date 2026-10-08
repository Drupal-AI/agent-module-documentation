#!/usr/bin/env bash
# Introspection SETUP: write a known media_directories_editor.settings state (a curated
# embed-dialog image-style list) so an inspecting agent can read it back from the live site.
# The matching cleanup restores the shipped default (empty list = show all styles).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  \Drupal::configFactory()->getEditable("media_directories_editor.settings")
    ->set("embed_dialog.image_styles", ["thumbnail", "medium", "wide"])
    ->save();
' >/dev/null 2>&1

echo "setup: media_directories_editor.settings embed_dialog.image_styles = [thumbnail, medium, wide]"
