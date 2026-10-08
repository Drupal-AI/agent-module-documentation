#!/usr/bin/env bash
# Execution VERIFY: PASS when BOTH (a) autoban.settings autoban_query_mode === "REGEXP" and
# (b) the autoban rule 'autoban_test_403' exists with type 'access denied', threshold 3,
# provider 'ban', user_type anonymous (1). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $mode = \Drupal::config("autoban.settings")->get("autoban_query_mode");
  $e = \Drupal::entityTypeManager()->getStorage("autoban")->load("autoban_test_403");
  $rule_ok = $e && $e->type === "access denied" && (int) $e->threshold === 3
    && $e->provider === "ban" && (int) $e->user_type === 1;
  $ok = ($mode === "REGEXP" && $rule_ok);
  print ($ok?"PASS":"FAIL")." query_mode=".var_export($mode,true)
    ." rule=".($e?"present":"missing")
    ." type=".($e?var_export($e->type,true):"-")." thr=".($e?var_export($e->threshold,true):"-")
    ." prov=".($e?var_export($e->provider,true):"-")."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
