#!/usr/bin/env bash
# Execution VERIFY: PASS when readonlymode.settings enabled is truthy (Read Only Mode on).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("readonlymode.settings")->get("enabled");
  $ok = !empty($v);
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
