#!/usr/bin/env bash
# Introspection SETUP: role bts_perm_role granted 'administer nodes', user bts_perm_user holds it.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role; use Drupal\user\Entity\User;
  $r = Role::load("bts_perm_role") ?: Role::create(["id"=>"bts_perm_role","label"=>"BTS Perm Role"]);
  $r->grantPermission("administer nodes"); $r->save();
  $u = user_load_by_name("bts_perm_user") ?: User::create(["name"=>"bts_perm_user","mail"=>"bts_perm_user@example.com","status"=>1]);
  $u->addRole("bts_perm_role"); $u->save();
' >/dev/null 2>&1
echo "setup: user bts_perm_user has role bts_perm_role granting 'administer nodes'"
