#!/usr/bin/env bash
# Execution VERIFY (autoban_advban): PASS when rule 'autoban_test_range' exists and uses the
# Advanced Ban range provider (provider === 'advban_range'), scanning 'access denied' with
# threshold 3. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("autoban")->load("autoban_test_range");
  if (!$e) { print "FAIL missing rule\n"; return; }
  $ok = ($e->provider === "advban_range" && $e->type === "access denied" && (int) $e->threshold === 3);
  print ($ok?"PASS":"FAIL")." provider=".var_export($e->provider,true)." type=".var_export($e->type,true)." thr=".var_export($e->threshold,true)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
