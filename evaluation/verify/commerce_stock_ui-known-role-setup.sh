#!/usr/bin/env bash
# Introspection SETUP: create a role csu_known that has the 'use commerce stock transaction form'
# permission, for an agent to discover. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("csu_known")) { $r->delete(); }
  $r = Role::create(["id" => "csu_known", "label" => "CSU Known"]);
  $r->grantPermission("use commerce stock transaction form");
  $r->save();
' >/dev/null 2>&1
echo "setup: role csu_known granted 'use commerce stock transaction form'"
