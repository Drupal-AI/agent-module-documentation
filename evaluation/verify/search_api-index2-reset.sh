#!/usr/bin/env bash
# Reset for the "eval_index2 indexes title + body of Article" execution case. Deletes the
# eval_index2 index (references the server) first, then the eval_server2 server, so each run
# starts clean. Only touches eval_server2 / eval_index2 — leaves any other site search config
# (Solr/Pantheon) untouched. Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($i = \Drupal::entityTypeManager()->getStorage("search_api_index")->load("eval_index2")) { $i->delete(); }
  if ($s = \Drupal::entityTypeManager()->getStorage("search_api_server")->load("eval_server2")) { $s->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: search_api eval_index2 + eval_server2 removed"
