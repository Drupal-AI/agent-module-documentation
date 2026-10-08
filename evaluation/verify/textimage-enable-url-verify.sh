#!/usr/bin/env bash
# Execution VERIFY: PASS when textimage.settings url_generation.enabled === TRUE.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("textimage.settings")->get("url_generation.enabled");
  $ok = ($v === TRUE);
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
