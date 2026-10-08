#!/usr/bin/env bash
# Introspection SETUP: grant the global `create new menu` permission to the content_editor
# role so an inspecting agent can read it back. Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $role = \Drupal\user\Entity\Role::load("content_editor");
  if ($role && !$role->hasPermission("create new menu")) {
    $role->grantPermission("create new menu");
    $role->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: content_editor granted 'create new menu'"
