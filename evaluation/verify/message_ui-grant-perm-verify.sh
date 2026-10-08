#!/usr/bin/env bash
# Execution VERIFY: PASS when role 'message_ui_hrole' has 'create message_ui_hard message'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $r = \Drupal\user\Entity\Role::load("message_ui_hrole");
  $ok = $r && $r->hasPermission("create message_ui_hard message");
  print ($ok ? "PASS" : "FAIL")." has_perm=".var_export((bool)$ok,TRUE)."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
