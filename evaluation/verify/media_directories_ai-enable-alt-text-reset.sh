#!/usr/bin/env bash
# Execution RESET for "turn on AI alt text with a house prompt".
# Restores media_directories_ai.settings to shipped defaults (feature off, empty prompt, no
# fillable fields) so verify FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  \Drupal::configFactory()->getEditable("media_directories_ai.settings")
    ->set("enable_ai_alt_text", FALSE)
    ->set("alt_text_prompt", "")
    ->set("ai_fillable_fields", [])
    ->save();
' >/dev/null 2>&1

echo "reset: media_directories_ai alt-text feature off, prompt empty, no fillable fields"
