#!/usr/bin/env bash
# Introspection SETUP: role menu_ppm_reader2 with only 'delete links in footer menu from
# menu interface'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("menu_ppm_reader2") ?: Role::create(["id"=>"menu_ppm_reader2","label"=>"Menu PPM Reader 2"]);
  $r->grantPermission("delete links in footer menu from menu interface");
  $r->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: role menu_ppm_reader2 can delete links in footer menu"
