#!/usr/bin/env bash
# PASS when role tp_utask holds 'uninstall themes olivero'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role; $r = Role::load("tp_utask");
  $ok = $r && in_array("uninstall themes olivero", $r->getPermissions(), TRUE);
  print ($ok ? "PASS" : "FAIL")." perms=".($r ? implode("|",$r->getPermissions()) : "no-role")."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
