#!/usr/bin/env bash
# Introspection CLEANUP: restore media_directories_editor.settings to its shipped default
# (embed_dialog.image_styles empty = all styles shown). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  \Drupal::configFactory()->getEditable("media_directories_editor.settings")
    ->set("embed_dialog.image_styles", [])
    ->save();
' >/dev/null 2>&1

echo "cleanup: media_directories_editor.settings embed_dialog.image_styles cleared"
