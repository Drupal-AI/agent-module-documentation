#!/usr/bin/env bash
# Execution VERIFY: PASS when Context cadl_hard2 has a context_advanced_datalayer reaction whose
# 'event' datalayer value === 'ctxbuild'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $r = \Drupal::config("context.context.cadl_hard2")->get("reactions.context_advanced_datalayer");
  $v = is_array($r) ? ($r["event"] ?? NULL) : NULL;
  print (($v === "ctxbuild") ? "PASS" : "FAIL") . " event=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
