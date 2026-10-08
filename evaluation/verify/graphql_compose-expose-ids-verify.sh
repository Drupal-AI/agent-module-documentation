#!/usr/bin/env bash
# Execution VERIFY: PASS when settings.expose_entity_ids === TRUE. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v=\Drupal::config("graphql_compose.settings.graphql_compose_server")->get("settings.expose_entity_ids");
  print (($v===TRUE) ? "PASS" : "FAIL") . " expose_entity_ids=" . var_export($v,TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
