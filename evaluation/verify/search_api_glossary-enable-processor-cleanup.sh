#!/usr/bin/env bash
# Execution CLEANUP: delete the namespaced index + server. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($i = \Drupal::entityTypeManager()->getStorage("search_api_index")->load("sag_glossary_index")) { $i->delete(); }
  if ($s = \Drupal::entityTypeManager()->getStorage("search_api_server")->load("sag_glossary_server")) { $s->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: sag_glossary_index + server removed"
