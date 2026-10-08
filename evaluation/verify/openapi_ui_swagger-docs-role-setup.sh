#!/usr/bin/env bash
# Introspection SETUP: create a role that is allowed to reach the OpenAPI/Swagger UI
# documentation pages (openapi's 'access openapi api docs' permission), so an inspecting
# agent can work out which role may view them. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $role = Role::load("openapi_ui_swagger_viewer");
  if (!$role) {
    $role = Role::create(["id" => "openapi_ui_swagger_viewer", "label" => "OpenAPI Swagger Viewer"]);
  }
  $role->grantPermission("access openapi api docs");
  $role->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: role openapi_ui_swagger_viewer has 'access openapi api docs'"
