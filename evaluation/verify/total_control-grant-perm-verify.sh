#!/usr/bin/env bash
# Execution VERIFY: PASS when role tc_task has the 'have total control' permission. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $r = \Drupal\user\Entity\Role::load("tc_task");
  $ok = $r && in_array("have total control", $r->getPermissions(), TRUE);
  print (($ok) ? "PASS" : "FAIL") . " role=" . ($r ? "tc_task" : "MISSING") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
