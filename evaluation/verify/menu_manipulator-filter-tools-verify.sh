#!/usr/bin/env bash
# Execution VERIFY: PASS when menu_manipulator.settings has the 'tools' menu active in
# preprocess_menus_language_list (value === 'tools'). Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $list = \Drupal::config("menu_manipulator.settings")->get("preprocess_menus_language_list") ?: [];
  $v = $list["tools"] ?? "";
  $ok = ($v === "tools");
  print ($ok ? "PASS" : "FAIL") . " tools=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
