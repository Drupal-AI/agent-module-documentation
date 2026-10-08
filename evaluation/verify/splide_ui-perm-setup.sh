#!/usr/bin/env bash
# Introspection SETUP: create role spl_ui_role granted 'administer splide' so an agent can read back
# which role can manage Splide optionsets. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("spl_ui_role") ?: Role::create(["id"=>"spl_ui_role","label"=>"SPL UI Role"]);
  $r->grantPermission("administer splide"); $r->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: role spl_ui_role has 'administer splide'"
