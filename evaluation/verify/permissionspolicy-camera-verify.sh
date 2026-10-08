#!/usr/bin/env bash
# Execution VERIFY: PASS when camera is restricted to same-origin (base 'self'). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $base = \Drupal::config("permissionspolicy.settings")->get("enforce.features.camera.base");
  $ok = ($base === "self");
  print ($ok ? "PASS" : "FAIL") . " camera.base=" . var_export($base, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
