#!/usr/bin/env bash
# Execution VERIFY: PASS when the autoban rule 'autoban_test_404' exists with the required
# fields: type 'page not found', message 'phpmyadmin', threshold 10, window '6 hours',
# provider 'ban', user_type anonymous (1). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("autoban")->load("autoban_test_404");
  if (!$e) { print "FAIL missing rule\n"; return; }
  $ok = ($e->type === "page not found" && $e->message === "phpmyadmin"
    && (int) $e->threshold === 10 && $e->window === "6 hours"
    && $e->provider === "ban" && (int) $e->user_type === 1);
  print ($ok?"PASS":"FAIL")." type=".var_export($e->type,true)." msg=".var_export($e->message,true)
    ." thr=".var_export($e->threshold,true)." win=".var_export($e->window,true)
    ." prov=".var_export($e->provider,true)." ut=".var_export($e->user_type,true)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
