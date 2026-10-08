#!/usr/bin/env bash
# Execution VERIFY: PASS when role 'mnui_new_sender' EXISTS and has 'send message through the ui'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $r=\Drupal\user\Entity\Role::load("mnui_new_sender");
  $ok=$r && $r->hasPermission("send message through the ui");
  print ($ok?"PASS":"FAIL")." exists=".var_export((bool)$r,TRUE)."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
