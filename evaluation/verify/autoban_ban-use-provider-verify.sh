#!/usr/bin/env bash
# Execution VERIFY (autoban_ban): PASS when rule 'autoban_test_bansub' exists and uses the core
# Ban provider (provider === 'ban'), scanning 'page not found' with threshold 5. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("autoban")->load("autoban_test_bansub");
  if (!$e) { print "FAIL missing rule\n"; return; }
  $ok = ($e->provider === "ban" && $e->type === "page not found" && (int) $e->threshold === 5);
  print ($ok?"PASS":"FAIL")." provider=".var_export($e->provider,true)." type=".var_export($e->type,true)." thr=".var_export($e->threshold,true)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
