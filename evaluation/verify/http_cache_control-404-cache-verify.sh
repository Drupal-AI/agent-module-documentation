#!/usr/bin/env bash
# Verify 404 responses are set to be cached by shared proxies for 900 seconds:
# cache.http.404_max_age == 900 in http_cache_control.settings.
# Prints PASS/FAIL and exits 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = (int) \Drupal::config("http_cache_control.settings")->get("cache.http.404_max_age");
  print "\n" . ($v === 900 ? "PASS" : "FAIL") . " 404_max_age=" . $v . "\n";
' 2>/dev/null)
echo "$out" | grep -E '^(PASS|FAIL)'
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
