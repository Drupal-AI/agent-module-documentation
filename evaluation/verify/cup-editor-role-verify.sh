#!/usr/bin/env bash
# Execution VERIFY: PASS when role cup_editor_role can create users but is NOT an admin, i.e.
# it holds 'create users' and does NOT hold 'administer users'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("cup_editor_role");
  $perms = $r ? $r->getPermissions() : [];
  $ok = in_array("create users", $perms, TRUE) && !in_array("administer users", $perms, TRUE);
  print ($ok ? "PASS" : "FAIL") . " create=" . var_export(in_array("create users", $perms, TRUE), TRUE)
    . " admin=" . var_export(in_array("administer users", $perms, TRUE), TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
