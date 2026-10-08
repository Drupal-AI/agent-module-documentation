#!/usr/bin/env bash
# Introspection SETUP: create role unp_known_role holding 'view article unpublished content' so an
# agent can inspect which content type it may view unpublished. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("unp_known_role") ?: Role::create(["id"=>"unp_known_role","label"=>"UNP Known Role"]);
  $r->grantPermission("view article unpublished content");
  $r->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: role unp_known_role has 'view article unpublished content'"
