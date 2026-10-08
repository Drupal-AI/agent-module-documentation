#!/usr/bin/env bash
# MEDIUM introspection setup: point acquia_search at a non-default Acquia Search API host,
# so the agent can be asked which endpoint the site is configured to talk to.
# Restored by acquia_search-api-host-cleanup.sh.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("acquia_search.settings")
    ->set("api_host", "https://api.sr-eu01.acquia.com")
    ->set("extract_query_handler_option", "update/extract")
    ->set("read_only", FALSE)
    ->set("override_search_core", NULL)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: acquia_search.settings api_host set to https://api.sr-eu01.acquia.com"
