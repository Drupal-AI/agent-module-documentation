#!/usr/bin/env bash
# Execution RESET: force google_translator.settings back to defaults (SIMPLE, [pt,es]) so verify
# FAILS until the agent adds 'ja' and sets HORIZONTAL. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("google_translator.settings")
    ->set("google_translator_active_languages_display_mode", "SIMPLE")
    ->set("google_translator_active_languages", ["pt", "es"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: google_translator settings = SIMPLE / [pt,es]"
