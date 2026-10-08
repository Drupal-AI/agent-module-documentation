#!/usr/bin/env bash
# Execution VERIFY: PASS when role cup_task_role holds the 'create users' permission.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("cup_task_role");
  $ok = $r && in_array("create users", $r->getPermissions(), TRUE);
  print ($ok ? "PASS" : "FAIL") . " create_users=" . var_export((bool) $ok, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
