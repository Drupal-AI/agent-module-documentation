#!/usr/bin/env bash
# Execution RESET: ensure role cup_task_role exists WITHOUT the 'create users' or
# 'administer users' permission, so verify FAILS until the agent grants 'create users'.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("cup_task_role") ?: Role::create(["id" => "cup_task_role", "label" => "CUP Task Role"]);
  $r->save();
  $r->revokePermission("create users");
  $r->revokePermission("administer users");
  $r->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: role cup_task_role present without 'create users'"
