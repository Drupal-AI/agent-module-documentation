#!/usr/bin/env bash
# Execution VERIFY: PASS when the TimelineJS library location is pinned to version 3.9.7
# (views_timelinejs.settings:library_location === "cdn_3.9.7"). Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("views_timelinejs.settings")->get("library_location");
  $ok = ($v === "cdn_3.9.7");
  print ($ok ? "PASS" : "FAIL") . " library_location=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
