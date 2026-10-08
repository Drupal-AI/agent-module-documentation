#!/usr/bin/env bash
# Execution VERIFY: PASS when menu_export.settings menus contains BOTH "menuexp_a" and
# "menuexp_b". Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $menus = \Drupal::config("menu_export.settings")->get("menus") ?: [];
  $ok = in_array("menuexp_a", $menus, TRUE) && in_array("menuexp_b", $menus, TRUE);
  print ($ok ? "PASS" : "FAIL") . " menus=[" . implode(",", $menus) . "]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
