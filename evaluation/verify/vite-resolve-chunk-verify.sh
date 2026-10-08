#!/usr/bin/env bash
# Execution VERIFY: PASS when state vite_eval_hard_result equals the built path that vite's
# Manifest resolves for source entry src/app.ts, i.e. 'assets/app-XYZ789.js'. exit 0 / 1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $got = \Drupal::state()->get("vite_eval_hard_result");
  $expected = "assets/app-XYZ789.js";
  $ok = is_string($got) && trim($got) === $expected;
  print ($ok ? "PASS" : "FAIL") . " expected=" . $expected . " got=" . var_export($got, true) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
