#!/usr/bin/env bash
# Execution CLEANUP for "turn on AI alt text with a house prompt": restores the shipped
# defaults (feature off, empty prompt, no fillable fields) so the site is left clean.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  \Drupal::configFactory()->getEditable("media_directories_ai.settings")
    ->set("enable_ai_alt_text", FALSE)
    ->set("alt_text_prompt", "")
    ->set("ai_fillable_fields", [])
    ->save();
' >/dev/null 2>&1

echo "cleanup: media_directories_ai alt-text feature off, prompt empty, no fillable fields"
