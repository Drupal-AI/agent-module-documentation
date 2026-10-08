#!/usr/bin/env bash
# Introspection SETUP: create two roles, lbcs_can (has 'copy paste sections') and lbcs_cannot
# (does not), so the agent must find which one can copy/paste sections. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $a = Role::load("lbcs_can") ?: Role::create(["id"=>"lbcs_can","label"=>"LBCS Can"]);
  $a->grantPermission("copy paste sections")->save();
  $b = Role::load("lbcs_cannot") ?: Role::create(["id"=>"lbcs_cannot","label"=>"LBCS Cannot"]);
  $b->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: lbcs_can has permission, lbcs_cannot does not"
