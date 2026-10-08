#!/usr/bin/env bash
# Introspection SETUP: create role menu_ppm_reader with the permission
# 'add new links to main menu from menu interface'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("menu_ppm_reader") ?: Role::create(["id"=>"menu_ppm_reader","label"=>"Menu PPM Reader"]);
  $r->grantPermission("add new links to main menu from menu interface");
  $r->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: role menu_ppm_reader has 'add new links to main menu from menu interface'"
