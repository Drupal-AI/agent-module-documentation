#!/usr/bin/env bash
# Execution RESET: ensure role cup_editor_role exists with NEITHER 'create users' nor
# 'administer users'. Verify FAILS until the agent grants only 'create users'. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("cup_editor_role") ?: Role::create(["id" => "cup_editor_role", "label" => "CUP Editor Role"]);
  $r->save();
  $r->revokePermission("create users");
  $r->revokePermission("administer users");
  $r->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: role cup_editor_role present without create/administer users"
