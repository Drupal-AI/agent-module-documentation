#!/usr/bin/env bash
# Execution VERIFY: PASS when puphpeteer.settings pagedjs === TRUE.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("puphpeteer.settings")->get("pagedjs");
  $ok = ($v === TRUE);
  print ($ok ? "PASS" : "FAIL") . " pagedjs=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
