#!/usr/bin/env bash
# Execution VERIFY: PASS when photos.settings:photos_num === 8. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("photos.settings")->get("photos_num");
  $ok = ((int) $v === 8);
  print ($ok ? "PASS" : "FAIL") . " photos_num=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
