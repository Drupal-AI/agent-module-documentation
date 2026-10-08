#!/usr/bin/env bash
# Introspection CLEANUP: delete cup_role_on and cup_role_off. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  foreach (["cup_role_on", "cup_role_off"] as $id) { if ($r = Role::load($id)) { $r->delete(); } }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: cup_role_on and cup_role_off removed"
