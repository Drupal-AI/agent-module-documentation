#!/usr/bin/env bash
# Execution VERIFY: PASS when intercept_redirects===true AND purge_on_cache_clear===false.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("webprofiler.settings");
  $ok = ($c->get("intercept_redirects") == TRUE) && ($c->get("purge_on_cache_clear") == FALSE);
  print ($ok ? "PASS" : "FAIL") . " intercept=" . var_export($c->get("intercept_redirects"),TRUE) . " purge=" . var_export($c->get("purge_on_cache_clear"),TRUE);
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
