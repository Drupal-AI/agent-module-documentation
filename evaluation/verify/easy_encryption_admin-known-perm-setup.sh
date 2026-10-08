#!/usr/bin/env bash
# Introspection SETUP: create role eea_viewer granted the Easy Encryption keys admin permission.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("eea_viewer") ?: Role::create(["id"=>"eea_viewer","label"=>"EEA Viewer"]);
  $r->grantPermission("administer easy encryption keys");
  $r->save();
' >/dev/null 2>&1
echo "setup: role eea_viewer granted the EE keys admin permission"
