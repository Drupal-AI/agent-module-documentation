#!/usr/bin/env bash
# Introspection CLEANUP: delete both probe roles. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  foreach (["phd_owner", "phd_editor"] as $id) {
    if ($role = Role::load($id)) { $role->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: roles phd_owner and phd_editor removed"
