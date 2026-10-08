#!/usr/bin/env bash
# HARD execution reset: remove the Acquia Search Solr server config entity so the
# "create the acquia_search_server" build task starts from a missing (failing) state.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("search_api_server")->load("acquia_search_server");
  if ($s) { $s->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: acquia_search_server removed (if it existed)"
