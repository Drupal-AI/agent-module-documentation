#!/usr/bin/env bash
# Introspection CLEANUP: remove the known eval_intro_* Search API entities, restoring baseline.
# Delete the index first (it references the server), then the server. Idempotent: no-op if
# already gone. Only touches eval_intro_* entities. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($i = \Drupal::entityTypeManager()->getStorage("search_api_index")->load("eval_intro_index")) { $i->delete(); }
  if ($s = \Drupal::entityTypeManager()->getStorage("search_api_server")->load("eval_intro_server")) { $s->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: eval_intro_index + eval_intro_server removed"
