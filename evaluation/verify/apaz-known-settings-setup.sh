#!/usr/bin/env bash
# Introspection SETUP: write a known marker into ai_provider_azure.settings:data so an agent can read
# the module's own config back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("ai_provider_azure.settings")->set("data", "AZURE_PROFILE_MARKER_42")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ai_provider_azure.settings data = AZURE_PROFILE_MARKER_42"
