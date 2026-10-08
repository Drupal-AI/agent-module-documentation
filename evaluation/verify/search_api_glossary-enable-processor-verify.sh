#!/usr/bin/env bash
# Execution VERIFY: PASS when search_api.index.sag_glossary_index processor_settings contains
# 'glossary'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("search_api.index.sag_glossary_index");
  $procs = array_keys((array) $c->get("processor_settings"));
  $ok = in_array("glossary", $procs, TRUE);
  print ($ok ? "PASS" : "FAIL") . " processors=" . implode(",", $procs) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
