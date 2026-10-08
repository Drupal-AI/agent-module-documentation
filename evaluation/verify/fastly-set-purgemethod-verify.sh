#!/usr/bin/env bash
# Execution VERIFY: PASS when fastly.settings purge_method === 'soft'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("fastly.settings")->get("purge_method");
  $ok = ($v === "soft");
  print ($ok ? "PASS" : "FAIL") . " purge_method=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
