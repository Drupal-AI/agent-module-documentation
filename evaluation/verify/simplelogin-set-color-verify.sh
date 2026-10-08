#!/usr/bin/env bash
# Execution VERIFY: PASS when simplelogin.settings background_color === '#ff8800'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("simplelogin.settings")->get("background_color");
  print (($v==="#ff8800") ? "PASS" : "FAIL") . " background_color=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
