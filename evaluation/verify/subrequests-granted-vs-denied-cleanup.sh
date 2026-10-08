#!/usr/bin/env bash
# Introspection CLEANUP: remove both roles created by the matching setup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($role = Role::load("subreq_role_on")) { $role->delete(); }
  if ($role = Role::load("subreq_role_off")) { $role->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: subreq_role_on and subreq_role_off removed"
