#!/usr/bin/env bash
# Execution VERIFY: PASS when blazy.settings extras.photoswipe === 5 (PhotoSwipe 5 selected).
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("blazy.settings")->get("extras.photoswipe");
  $ok = ((int) $v === 5);
  print ($ok ? "PASS" : "FAIL") . " extras.photoswipe=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
