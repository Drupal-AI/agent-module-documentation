#!/usr/bin/env bash
# Introspection SETUP: create role unp_any_role holding the site-wide 'view unpublished content'.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("unp_any_role") ?: Role::create(["id"=>"unp_any_role","label"=>"UNP Any Role"]);
  $r->grantPermission("view unpublished content");
  $r->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: role unp_any_role has 'view unpublished content'"
