#!/usr/bin/env bash
# MEDIUM (introspection) cleanup: restore the amazee.ai LLM gateway host and moderation flag
# to their config/install defaults.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("ai_provider_amazeeio.settings")
    ->set("host", "https://api.amazee.ai")
    ->set("moderation", FALSE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ai_provider_amazeeio host + moderation restored to defaults"
