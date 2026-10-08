#!/usr/bin/env bash
# Introspection SETUP: enable the AI alt-text master switch but leave everything else at
# defaults, so the agent has to inspect the RUNNING site (AiAltTextService::isAvailable() and
# the ai.provider default for chat_with_image_vision) rather than just read the config flag.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  \Drupal::configFactory()->getEditable("media_directories_ai.settings")
    ->set("enable_ai_alt_text", TRUE)
    ->set("ai_translation_types", [])
    ->save();
' >/dev/null 2>&1

state=$(drush php:eval 'print \Drupal::service("media_directories_ai.alt_text")->isAvailable() ? "AVAILABLE" : "NOT-AVAILABLE";' 2>/dev/null)
echo "setup: enable_ai_alt_text=TRUE; AiAltTextService::isAvailable() = ${state}"
