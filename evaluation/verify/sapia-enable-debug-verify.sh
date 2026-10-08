#!/usr/bin/env bash
# Execution VERIFY: PASS when search_api_algolia.settings.debug is TRUE. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $d = \Drupal::config("search_api_algolia.settings")->get("debug");
  $ok = ($d === TRUE || $d === 1 || $d === "1");
  print ($ok ? "PASS" : "FAIL") . " debug=" . var_export($d, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
