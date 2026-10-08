#!/usr/bin/env bash
# Restore shipped defaults for google_translator.settings. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("google_translator.settings")
    ->set("google_translator_active_languages_display_mode", "SIMPLE")
    ->set("google_translator_active_languages", ["pt", "es"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: google_translator settings restored to defaults"
