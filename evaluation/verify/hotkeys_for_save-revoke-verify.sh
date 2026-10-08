#!/usr/bin/env bash
# Execution VERIFY: PASS when role hfs_revoke still exists but NO LONGER has the permission.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("hfs_revoke");
  if (!$r) { print "FAIL no-role\n"; return; }
  $has = $r->hasPermission("use hotkeys for save");
  print ((!$has) ? "PASS" : "FAIL")." hasPerm=".($has?"1":"0")."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
