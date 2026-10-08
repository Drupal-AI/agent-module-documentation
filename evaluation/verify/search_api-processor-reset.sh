#!/usr/bin/env bash
# Reset for the "eval_index3 with the HTML filter processor enabled" execution case. Deletes the
# eval_index3 index (references the server) first, then the eval_server3 server, so each run
# starts clean. Only touches eval_server3 / eval_index3 — leaves any other site search config
# (Solr/Pantheon) untouched. Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($i = \Drupal::entityTypeManager()->getStorage("search_api_index")->load("eval_index3")) { $i->delete(); }
  if ($s = \Drupal::entityTypeManager()->getStorage("search_api_server")->load("eval_server3")) { $s->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: search_api eval_index3 + eval_server3 removed"
