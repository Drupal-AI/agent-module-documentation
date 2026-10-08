#!/usr/bin/env bash
# Introspection CLEANUP: restore media_directories_ai.settings to the module's shipped
# config/install defaults. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  \Drupal::configFactory()->getEditable("media_directories_ai.settings")
    ->set("enable_ai_alt_text", FALSE)
    ->set("alt_text_prompt", "")
    ->set("ai_translation_types", [])
    ->set("translation_prompt", "")
    ->set("ai_fillable_fields", [])
    ->set("ai_translatable_fields", [])
    ->save();
' >/dev/null 2>&1

echo "cleanup: media_directories_ai.settings restored to shipped defaults"
