#!/usr/bin/env bash
# Execution CLEANUP: restore baseline search_api_algolia.settings.debug = false. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("search_api_algolia.settings")->set("debug", FALSE)->save();' >/dev/null 2>&1
echo "cleanup: search_api_algolia.settings.debug = FALSE (baseline)"
