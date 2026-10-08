#!/usr/bin/env bash
# Execution VERIFY: PASS when coi.settings override_behavior === 'noaccess'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("coi.settings")->get("override_behavior");
  $ok = ($v === "noaccess");
  print ($ok ? "PASS" : "FAIL") . " override_behavior=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
