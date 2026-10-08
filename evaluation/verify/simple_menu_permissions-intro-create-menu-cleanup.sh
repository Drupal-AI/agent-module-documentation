#!/usr/bin/env bash
# Introspection CLEANUP: restore baseline — revoke `create new menu` from the content_editor
# role. Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $role = \Drupal\user\Entity\Role::load("content_editor");
  if ($role && $role->hasPermission("create new menu")) {
    $role->revokePermission("create new menu");
    $role->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: content_editor no longer has 'create new menu'"
