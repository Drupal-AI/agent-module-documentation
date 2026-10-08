#!/usr/bin/env bash
# Execution VERIFY: PASS when keep_admin_menu == 1. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("gin_toolbar_custom_menu.settings")->get("keep_admin_menu");
  $ok = ((int)$v === 1);
  print ($ok?"PASS":"FAIL")." keep_admin_menu=".var_export($v,true)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
