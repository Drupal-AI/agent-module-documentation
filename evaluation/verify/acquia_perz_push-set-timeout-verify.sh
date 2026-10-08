#!/usr/bin/env bash
# Execution VERIFY: PASS when cis.endpoint_timeout === 10. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("acquia_perz_push.settings")->get("cis.endpoint_timeout");
  $ok = ((int) $v) === 10;
  print ($ok ? "PASS" : "FAIL") . " endpoint_timeout=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
