#!/usr/bin/env bash
# Introspection CLEANUP: turn the AI alt-text master switch back off (shipped default).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  \Drupal::configFactory()->getEditable("media_directories_ai.settings")
    ->set("enable_ai_alt_text", FALSE)
    ->save();
' >/dev/null 2>&1

echo "cleanup: enable_ai_alt_text reset to FALSE"
