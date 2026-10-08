#!/usr/bin/env bash
# Execution RESET for "enable AI translation for image media".
# Clears the AI translation settings (no types, empty prompt, no translatable fields) and
# ensures the browser module's translation_types does not already include image, so verify
# FAILS on empty state. Idempotent. Exit 0.
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

echo "reset: ai_translation_types=[], translation_prompt empty, ai_translatable_fields={}, browser translation_types=[]"
