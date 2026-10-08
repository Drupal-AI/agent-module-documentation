#!/usr/bin/env bash
# Introspection SETUP: create a non-admin role that is granted the permission guarding the
# ReDoc explorer pages (`access openapi api docs`, defined by the openapi module and required
# by route openapi.documentation = /admin/config/services/openapi/{openapi_ui}/{generator}).
# The agent must find which role can reach the ReDoc page. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $role = Role::load("oui_redoc_explorer");
  if (!$role) {
    $role = Role::create(["id" => "oui_redoc_explorer", "label" => "OUI ReDoc explorer"]);
  }
  $role->grantPermission("access openapi api docs");
  $role->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: role oui_redoc_explorer granted 'access openapi api docs'"
