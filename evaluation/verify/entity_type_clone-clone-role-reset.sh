#!/usr/bin/env bash
# Execution RESET: create/refresh the source role etc_role_src with a known permission set and
# DELETE the target role etc_role_dst, so verify FAILS until the agent clones the role.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("etc_role_dst")) { $r->delete(); }
  if (!Role::load("etc_role_src")) {
    Role::create(["id" => "etc_role_src", "label" => "ETC Role Source"])->save();
  }
  $src = Role::load("etc_role_src");
  foreach ($src->getPermissions() as $p) { $src->revokePermission($p); }
  foreach (["access content", "access user profiles", "view own unpublished content"] as $p) {
    $src->grantPermission($p);
  }
  $src->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: etc_role_src has 3 permissions; etc_role_dst absent"
