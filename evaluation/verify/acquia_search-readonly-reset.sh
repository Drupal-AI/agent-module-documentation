#!/usr/bin/env bash
# HARD execution reset: return acquia_search.settings to install defaults (read_only off,
# no pinned core) so the read-only/pin-core build task starts from a clean, failing state.
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
echo "reset: acquia_search.settings read_only=FALSE, override_search_core=NULL"
