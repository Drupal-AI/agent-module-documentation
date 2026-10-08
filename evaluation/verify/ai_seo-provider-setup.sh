#!/usr/bin/env bash
# Introspection SETUP: set a distinctive provider_and_model on ai_seo.settings so an inspecting
# agent can read back which AI provider/model is configured. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("ai_seo.settings")
    ->set("provider_and_model", "evalprovider__evalmodel")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ai_seo.settings provider_and_model=evalprovider__evalmodel"
