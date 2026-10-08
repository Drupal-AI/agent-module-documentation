#!/usr/bin/env bash
# Execution VERIFY: PASS when system.performance ipless.enabled === TRUE. Prints PASS/FAIL.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("system.performance")->get("ipless.enabled");
  $ok = ($v === TRUE || $v === 1 || $v === "1");
  print ($ok ? "PASS" : "FAIL") . " ipless.enabled=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
