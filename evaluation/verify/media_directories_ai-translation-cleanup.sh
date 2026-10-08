#!/usr/bin/env bash
# Execution CLEANUP for "enable AI translation for image media": clears the AI translation
# settings and the browser module's translation_types back to their shipped defaults so the
# site is left clean. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  \Drupal::configFactory()->getEditable("media_directories_ai.settings")
    ->set("ai_translation_types", [])
    ->set("translation_prompt", "")
    ->set("ai_translatable_fields", [])
    ->save();
  \Drupal::configFactory()->getEditable("media_directories_browser.settings")
    ->set("translation_types", [])
    ->save();
' >/dev/null 2>&1

echo "cleanup: ai_translation_types=[], translation_prompt empty, ai_translatable_fields={}, browser translation_types=[]"
