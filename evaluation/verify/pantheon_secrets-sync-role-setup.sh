#!/usr/bin/env bash
# Introspection SETUP: create a role holding the pantheon_secrets sync permission so the agent
# must inspect live role config to answer. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("ps_known_role") ?: Role::create(["id" => "ps_known_role", "label" => "PS known role"]);
  $r->grantPermission("sync pantheon_secrets keys");
  $r->save();
' >/dev/null 2>&1
echo "setup: role ps_known_role has 'sync pantheon_secrets keys'"
