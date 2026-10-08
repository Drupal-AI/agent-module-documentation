#!/usr/bin/env bash
# Introspection SETUP: create role bts_sec_role and user bts_sec_user holding it. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role; use Drupal\user\Entity\User;
  if (!Role::load("bts_sec_role")) { Role::create(["id"=>"bts_sec_role","label"=>"BTS Sec Role"])->save(); }
  $u = user_load_by_name("bts_sec_user");
  if (!$u) { $u = User::create(["name"=>"bts_sec_user","mail"=>"bts_sec_user@example.com","status"=>1]); }
  $u->addRole("bts_sec_role"); $u->save();
' >/dev/null 2>&1
echo "setup: user bts_sec_user has role bts_sec_role"
