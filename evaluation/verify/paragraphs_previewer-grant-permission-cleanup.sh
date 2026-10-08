#!/usr/bin/env bash
# Execution CLEANUP: delete the pp_reviewer role. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($role = Role::load("pp_reviewer")) { $role->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: role pp_reviewer removed"
