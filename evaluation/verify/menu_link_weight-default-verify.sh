#!/usr/bin/env bash
# Execution VERIFY: PASS when menu_parent_form_selector === 'default'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("menu_link_weight.settings")->get("menu_parent_form_selector");
  print (($v === "default") ? "PASS" : "FAIL") . " menu_parent_form_selector=" . var_export($v,TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
