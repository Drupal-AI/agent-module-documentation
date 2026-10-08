#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $r = \Drupal\user\Entity\Role::load("sfmu_task");
  $ok = $r && in_array("administer salesforce mapping", $r->getPermissions(), TRUE);
  print (($ok) ? "PASS" : "FAIL") . " has_perm=" . var_export($ok, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
