#!/usr/bin/env bash
# Introspection CLEANUP: delete the role created by the matching setup. Restores baseline.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($role = \Drupal\user\Entity\Role::load("openapi_ui_swagger_viewer")) { $role->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: role openapi_ui_swagger_viewer removed"
