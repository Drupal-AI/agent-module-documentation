#!/usr/bin/env bash
# Execution VERIFY: PASS when a role csu_clerk exists AND has the transaction-form permission.
# Pure read. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $r = \Drupal\user\Entity\Role::load("csu_clerk");
  $ok = $r && in_array("use commerce stock transaction form", $r->getPermissions(), TRUE);
  print (($ok) ? "PASS" : "FAIL") . " role=" . ($r ? "exists" : "missing") . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
