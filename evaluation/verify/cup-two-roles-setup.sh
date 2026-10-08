#!/usr/bin/env bash
# Introspection SETUP: create two roles cup_role_on (has 'create users') and cup_role_off
# (does not). Agent must identify which one can create users. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $on = Role::load("cup_role_on") ?: Role::create(["id" => "cup_role_on", "label" => "CUP Role On"]);
  $on->save();
  $on->grantPermission("create users")->save();
  $off = Role::load("cup_role_off") ?: Role::create(["id" => "cup_role_off", "label" => "CUP Role Off"]);
  $off->revokePermission("create users");
  $off->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: cup_role_on has 'create users', cup_role_off does not"
