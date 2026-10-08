#!/usr/bin/env bash
# Introspection CLEANUP: restore ai_seo.settings provider_and_model to its shipped default (''). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("ai_seo.settings")
    ->set("provider_and_model", "")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ai_seo.settings provider_and_model reset to ''"
