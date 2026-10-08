#!/usr/bin/env bash
# Introspection SETUP: create a role holding one theme-scoped and one provider-scoped
# block_permissions permission, so the agent must read live role config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("bp_known_role") ?: Role::create(["id" => "bp_known_role", "label" => "BP known role"]);
  $r->grantPermission("administer blocks");
  $r->grantPermission("administer block settings for theme claro");
  $r->grantPermission("administer blocks provided by views");
  $r->save();
' >/dev/null 2>&1
echo "setup: role bp_known_role -> theme claro + provider views"
