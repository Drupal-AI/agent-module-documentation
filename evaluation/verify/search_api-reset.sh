#!/usr/bin/env bash
# Reset the Search API eval setup to a clean baseline between runs so each condition is
# independent: delete the eval index first (it references the server), then the eval server,
# then rebuild caches. Only touches the eval_* entities, leaving any other site search config
# (e.g. an existing Solr/Pantheon server) untouched.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $im = \Drupal::entityTypeManager()->getStorage("search_api_index");
  if ($i = $im->load("eval_index")) { $i->delete(); }
  $sm = \Drupal::entityTypeManager()->getStorage("search_api_server");
  if ($s = $sm->load("eval_db_server")) { $s->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: search_api eval_index + eval_db_server removed"
