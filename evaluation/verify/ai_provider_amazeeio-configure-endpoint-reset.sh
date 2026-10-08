#!/usr/bin/env bash
# HARD (execution) reset: put ai_provider_amazeeio.settings back to a clean baseline so the
# task starts from empty state — host at the install default, moderation off. The agent must
# then repoint host at the requested self-hosted gateway and enable moderation.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("ai_provider_amazeeio.settings")
    ->set("host", "https://api.amazee.ai")
    ->set("moderation", FALSE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: ai_provider_amazeeio host + moderation restored to baseline"
