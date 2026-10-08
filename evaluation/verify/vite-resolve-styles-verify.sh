#!/usr/bin/env bash
# Execution VERIFY: PASS when state vite_eval_css_result equals the CSS file vite's Manifest
# associates with source entry src/widget.ts, i.e. 'assets/widget-CSS111.css'. exit 0 / 1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $got = \Drupal::state()->get("vite_eval_css_result");
  $expected = "assets/widget-CSS111.css";
  $ok = is_string($got) && trim($got) === $expected;
  print ($ok ? "PASS" : "FAIL") . " expected=" . $expected . " got=" . var_export($got, true) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
