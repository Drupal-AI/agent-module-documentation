#!/usr/bin/env bash
# Execution VERIFY: PASS when the search placeholder text is exactly 'Type to search'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $p = \Drupal::config("better_search.settings")->get("placeholder_text");
  print (($p === "Type to search") ? "PASS" : "FAIL") . " placeholder=" . var_export($p, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
