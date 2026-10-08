#!/usr/bin/env bash
# Introspection CLEANUP: delete the role created by the matching setup. Restores baseline
# (no non-admin role holds 'access openapi api docs'). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($role = Role::load("oui_redoc_explorer")) { $role->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: role oui_redoc_explorer removed"
