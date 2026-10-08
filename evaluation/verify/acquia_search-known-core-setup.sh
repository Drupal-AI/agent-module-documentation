#!/usr/bin/env bash
# MEDIUM introspection setup: pin acquia_search to a known Solr core and turn on read-only,
# so the agent can be asked to read back the pinned core id + read-only state from live config.
# Restored by acquia_search-known-core-cleanup.sh.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("acquia_search.settings")
    ->set("api_host", "https://api.sr-prod02.acquia.com")
    ->set("extract_query_handler_option", "update/extract")
    ->set("read_only", TRUE)
    ->set("override_search_core", "ZZZZ-99999.prod.knownsite")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: acquia_search pinned to core ZZZZ-99999.prod.knownsite, read_only=TRUE"
