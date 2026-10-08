#!/usr/bin/env bash
# Live-state verification for "enable content-view counting".
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Reads statistics.settings:count_content_views live and passes iff it equals 1.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $v = (int) \Drupal::config("statistics.settings")->get("count_content_views");
  print ($v === 1 ? "PASS" : "FAIL") . " count_content_views=" . $v . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
