#!/usr/bin/env bash
# Introspection SETUP: configure a known safety setting (HARM_CATEGORY_HARASSMENT =>
# BLOCK_ONLY_HIGH) in gemini_provider.settings so the agent must read the config back.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("gemini_provider.settings")
    ->set("safety_settings", ["HARM_CATEGORY_HARASSMENT" => "BLOCK_ONLY_HIGH"])->save();
' >/dev/null 2>&1
echo "setup: safety_settings HARM_CATEGORY_HARASSMENT=BLOCK_ONLY_HIGH"
