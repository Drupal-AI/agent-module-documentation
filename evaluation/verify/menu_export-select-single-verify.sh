#!/usr/bin/env bash
# Execution VERIFY: PASS when menu_export.settings menus contains "menuexp_task".
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $menus = \Drupal::config("menu_export.settings")->get("menus") ?: [];
  $ok = in_array("menuexp_task", $menus, TRUE);
  print ($ok ? "PASS" : "FAIL") . " menus=[" . implode(",", $menus) . "]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
