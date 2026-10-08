#!/usr/bin/env bash
# Execution VERIFY: PASS when subfields.secret_note.enabled === false.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("graphql_compose.settings")->get("field_config.node.cfgql_eval.field_cfgql.subfields.secret_note.enabled");
  print (($v === FALSE) ? "PASS" : "FAIL")." enabled=".var_export($v,true)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
