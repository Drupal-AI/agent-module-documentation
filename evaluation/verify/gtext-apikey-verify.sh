#!/usr/bin/env bash
# Execution VERIFY: PASS when gtext.settings:google_api_key equals the requested target key.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
TARGET="AIzaSyGTEXT-task-target-key-789"
out=$(drush php:eval '
  $k = \Drupal::config("gtext.settings")->get("google_api_key");
  $ok = ($k === "'"$TARGET"'");
  print ($ok ? "PASS" : "FAIL") . " google_api_key=" . var_export($k, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
