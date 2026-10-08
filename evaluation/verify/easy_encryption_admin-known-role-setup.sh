#!/usr/bin/env bash
# Introspection SETUP: create role eea_operator with the 'administer easy encryption keys' permission.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("eea_operator") ?: Role::create(["id"=>"eea_operator","label"=>"EEA Operator"]);
  $r->grantPermission("administer easy encryption keys");
  $r->save();
' >/dev/null 2>&1
echo "setup: role eea_operator has 'administer easy encryption keys'"
