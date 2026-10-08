#!/usr/bin/env bash
# Introspection CLEANUP: restore ai_provider_azure.settings:data to its shipped default (empty). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("ai_provider_azure.settings")->set("data", "")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ai_provider_azure.settings data restored to empty"
