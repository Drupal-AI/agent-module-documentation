#!/usr/bin/env bash
# Execution VERIFY: PASS when menu_manipulator.settings has the 'main' menu active in
# preprocess_menus_icon_list (value === 'main') and preprocess_menus_icon is enabled.
# Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $cfg = \Drupal::config("menu_manipulator.settings");
  $on = !empty($cfg->get("preprocess_menus_icon"));
  $list = $cfg->get("preprocess_menus_icon_list") ?: [];
  $v = $list["main"] ?? "";
  $ok = ($on && $v === "main");
  print ($ok ? "PASS" : "FAIL") . " icon_on=" . var_export($on, TRUE) . " main=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
