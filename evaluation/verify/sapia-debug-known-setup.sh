#!/usr/bin/env bash
# Introspection SETUP: enable debug in search_api_algolia.settings so an inspecting agent can read
# it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("search_api_algolia.settings")->set("debug", TRUE)->save();' >/dev/null 2>&1
echo "setup: search_api_algolia.settings.debug = TRUE"
