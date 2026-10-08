#!/usr/bin/env bash
# Execution RESET: clear ai_provider_azure.settings:data so verify FAILS until the agent records the
# deployment identifier. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("ai_provider_azure.settings")->set("data", "")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: ai_provider_azure.settings data = '' (empty)"
