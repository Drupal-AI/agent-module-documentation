#!/usr/bin/env bash
# Execution VERIFY: PASS when the youtube service is enabled, i.e.
# tacjs.settings services.youtube.status === TRUE.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::config("tacjs.settings")->get("services") ?? [];
  $ok = !empty($s["youtube"]["status"]);
  print ($ok ? "PASS" : "FAIL") . " youtube=" . var_export($s["youtube"] ?? NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
