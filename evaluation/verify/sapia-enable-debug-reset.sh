#!/usr/bin/env bash
# Execution RESET: force search_api_algolia.settings.debug = false, so verify FAILS until the
# agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("search_api_algolia.settings")->set("debug", FALSE)->save();' >/dev/null 2>&1
echo "reset: search_api_algolia.settings.debug = FALSE"
