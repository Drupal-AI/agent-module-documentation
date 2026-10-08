#!/usr/bin/env bash
# Execution VERIFY: PASS when role csu_task has the 'use commerce stock transaction form'
# permission. Pure read. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $r = \Drupal\user\Entity\Role::load("csu_task");
  $ok = $r && in_array("use commerce stock transaction form", $r->getPermissions(), TRUE);
  print (($ok) ? "PASS" : "FAIL") . " perms=" . json_encode($r ? array_values($r->getPermissions()) : null) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
