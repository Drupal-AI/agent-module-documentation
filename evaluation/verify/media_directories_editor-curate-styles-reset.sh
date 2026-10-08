#!/usr/bin/env bash
# Execution RESET for "curate the embed dialog image styles".
# Clears media_directories_editor.settings:embed_dialog.image_styles (shipped default: empty =
# all styles shown) so verify FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  \Drupal::configFactory()->getEditable("media_directories_editor.settings")
    ->set("embed_dialog.image_styles", [])
    ->save();
' >/dev/null 2>&1

echo "reset: media_directories_editor embed_dialog.image_styles cleared"
