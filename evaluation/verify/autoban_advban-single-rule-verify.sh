#!/usr/bin/env bash
# Execution VERIFY (autoban_advban): PASS when rule 'autoban_test_single' exists and uses the
# Advanced Ban SINGLE provider (provider === 'advban'), scanning 'page not found' with
# threshold 8. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("autoban")->load("autoban_test_single");
  if (!$e) { print "FAIL missing rule\n"; return; }
  $ok = ($e->provider === "advban" && $e->type === "page not found" && (int) $e->threshold === 8);
  print ($ok?"PASS":"FAIL")." provider=".var_export($e->provider,true)." type=".var_export($e->type,true)." thr=".var_export($e->threshold,true)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
