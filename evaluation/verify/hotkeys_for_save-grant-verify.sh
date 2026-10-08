#!/usr/bin/env bash
# Execution VERIFY: PASS when role hfs_target exists AND has the 'use hotkeys for save' permission.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("hfs_target");
  if (!$r) { print "FAIL no-role\n"; return; }
  $ok = $r->hasPermission("use hotkeys for save");
  print ($ok ? "PASS" : "FAIL")." hasPerm=".($ok?"1":"0")."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
