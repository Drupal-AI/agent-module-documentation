#!/usr/bin/env bash
# Execution VERIFY: PASS when role 'mnui_hard' has 'send message through the ui'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $r=\Drupal\user\Entity\Role::load("mnui_hard");
  $ok=$r && $r->hasPermission("send message through the ui");
  print ($ok?"PASS":"FAIL")." has=".var_export((bool)$ok,TRUE)."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
