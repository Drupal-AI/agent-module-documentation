#!/usr/bin/env bash
# Execution VERIFY: PASS when menu_select.settings search_enabled === FALSE. exit 0 pass/1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("menu_select.settings")->get("search_enabled");
  print (($v === FALSE) ? "PASS" : "FAIL") . " search_enabled=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
