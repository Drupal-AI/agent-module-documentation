#!/usr/bin/env bash
# Execution VERIFY: PASS when settings has a rule whose menu is 'main' and whose roles include
# 'authenticated'. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $rules = \Drupal::config("gin_toolbar_custom_menu.settings")->get("settings") ?: [];
  $ok = FALSE;
  foreach ($rules as $r) {
    $roles = $r["role"] ?? [];
    if (($r["menu"] ?? "") === "main" && in_array("authenticated", array_values($roles), TRUE)) { $ok = TRUE; }
  }
  print ($ok?"PASS":"FAIL")." rules=".count($rules)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
