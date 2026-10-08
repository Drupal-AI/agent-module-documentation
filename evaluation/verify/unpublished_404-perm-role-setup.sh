#!/usr/bin/env bash
# Introspection SETUP: create role u404_editor granted 'view own unpublished content' (the permission
# that exempts a user from the 403->404 behavior), so an agent can read back which role has it. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("u404_editor") ?: Role::create(["id" => "u404_editor", "label" => "U404 Editor"]);
  $r->grantPermission("view own unpublished content");
  $r->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: role u404_editor has 'view own unpublished content'"
