#!/usr/bin/env bash
# Execution VERIFY: PASS when the animation theme is 1 (Expand on Hover). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $t = \Drupal::config("better_search.settings")->get("theme");
  print (((int) $t === 1) ? "PASS" : "FAIL") . " theme=" . var_export($t, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
