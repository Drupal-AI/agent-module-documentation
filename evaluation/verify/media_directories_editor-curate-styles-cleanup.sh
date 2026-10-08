#!/usr/bin/env bash
# Execution CLEANUP for "curate the embed dialog image styles".
# Clears media_directories_editor.settings:embed_dialog.image_styles (shipped default: empty =
# all styles shown) so the site is left clean. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  \Drupal::configFactory()->getEditable("media_directories_editor.settings")
    ->set("embed_dialog.image_styles", [])
    ->save();
' >/dev/null 2>&1

echo "cleanup: media_directories_editor embed_dialog.image_styles cleared"
