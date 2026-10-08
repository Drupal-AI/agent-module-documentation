#!/usr/bin/env bash
# Execution VERIFY: PASS when role spl_ui_editor exists AND has 'administer splide'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("spl_ui_editor");
  $ok = ($r && $r->hasPermission("administer splide"));
  print ($ok?"PASS":"FAIL")." role=".($r?"yes":"no")." perm=".($r && $r->hasPermission("administer splide")?"yes":"no");
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
