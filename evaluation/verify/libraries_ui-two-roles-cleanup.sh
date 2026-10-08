#!/usr/bin/env bash
# Introspection CLEANUP: delete both roles from the two-roles setup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  foreach (["libraries_ui_allowed", "libraries_ui_denied"] as $id) { if ($r = Role::load($id)) { $r->delete(); } }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: libraries_ui_allowed and libraries_ui_denied removed"
