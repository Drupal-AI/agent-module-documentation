#!/usr/bin/env bash
# Execution VERIFY: PASS when the active theme's settings has layouts_enable = 1 (the key at_tool
# reads for layout-settings CSS). Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $t = \Drupal::config("system.theme")->get("default");
  $s = \Drupal::config("$t.settings")->get("settings") ?? [];
  $le = $s["layouts_enable"] ?? NULL;
  $ok = ((int) $le === 1);
  print ($ok ? "PASS" : "FAIL") . " theme=" . $t . " layouts_enable=" . var_export($le, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
