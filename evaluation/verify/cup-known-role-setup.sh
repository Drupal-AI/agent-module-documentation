#!/usr/bin/env bash
# Introspection SETUP: create a role cup_known_creator and grant it the create_user_permission
# 'create users' permission, so an inspecting agent can read back which role has it.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("cup_known_creator") ?: Role::create(["id" => "cup_known_creator", "label" => "CUP Known Creator"]);
  $r->save();
  $r->grantPermission("create users")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: role cup_known_creator granted 'create users'"
