#!/usr/bin/env bash
# MEDIUM introspection cleanup: restore acquia_search.settings to its install defaults.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("acquia_search.settings")
    ->set("api_host", "https://api.sr-prod02.acquia.com")
    ->set("extract_query_handler_option", "update/extract")
    ->set("read_only", FALSE)
    ->set("override_search_core", NULL)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: acquia_search.settings restored to install defaults"
