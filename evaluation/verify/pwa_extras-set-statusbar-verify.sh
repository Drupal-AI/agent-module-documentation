#!/usr/bin/env bash
# Execution VERIFY: PASS when color_select === 'black_translucent'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("pwa_extras.settings.apple")->get("color_select");
  print (($v === "black_translucent") ? "PASS" : "FAIL") . " color_select=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
