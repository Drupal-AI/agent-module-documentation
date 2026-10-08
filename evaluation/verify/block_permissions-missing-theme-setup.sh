#!/usr/bin/env bash
# Introspection SETUP: create a role with the core block permission and a provider permission
# but NO theme permission, so the agent has to work out (from live role + system.theme config)
# why it still cannot open /admin/structure/block. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("bp_locked_role") ?: Role::create(["id" => "bp_locked_role", "label" => "BP locked role"]);
  $r->grantPermission("administer blocks");
  $r->grantPermission("administer blocks provided by system");
  $r->revokePermission("administer block settings for theme olivero");
  $r->revokePermission("administer block settings for theme claro");
  $r->save();
' >/dev/null 2>&1
echo "setup: role bp_locked_role has 'administer blocks' + provider system, but no theme permission"
