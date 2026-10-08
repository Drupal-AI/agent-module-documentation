#!/usr/bin/env bash
# Execution VERIFY: PASS when onlyone_new_menu_entry is true. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("onlyone.settings")->get("onlyone_new_menu_entry");
  $ok = ($v === TRUE);
  print ($ok ? "PASS" : "FAIL") . " onlyone_new_menu_entry=" . var_export($v,true) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
