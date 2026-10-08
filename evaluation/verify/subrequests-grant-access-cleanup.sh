#!/usr/bin/env bash
# Execution CLEANUP: remove the role created by the matching reset. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($role = Role::load("subreq_client_role")) { $role->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: role subreq_client_role removed"
