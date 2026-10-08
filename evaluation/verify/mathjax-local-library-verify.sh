#!/usr/bin/env bash
# Execution VERIFY: PASS when mathjax.settings says use_cdn = 0 (local /libraries/MathJax copy)
# AND enable_for_admin = 1. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("mathjax.settings");
  $cdn = $c->get("use_cdn");
  $admin = $c->get("enable_for_admin");
  $ok = ((int) $cdn === 0) && ((int) $admin === 1);
  print ($ok ? "PASS" : "FAIL") . " use_cdn=" . var_export($cdn, TRUE) . " enable_for_admin=" . var_export($admin, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
