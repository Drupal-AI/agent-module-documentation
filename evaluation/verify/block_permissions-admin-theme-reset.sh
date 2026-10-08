#!/usr/bin/env bash
# Execution RESET: create the role WITHOUT any block_permissions permissions, so verify fails
# until the agent grants the right two. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("bp_claro_role")) { $r->delete(); }
  $r = Role::create(["id" => "bp_claro_role", "label" => "BP claro role"]);
  $r->grantPermission("administer blocks");
  $r->save();
' >/dev/null 2>&1
echo "reset: role bp_claro_role exists with only core 'administer blocks'"
