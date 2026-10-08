#!/usr/bin/env bash
# Introspection SETUP: grant a KNOWN per-menu permission to the content_editor role so an
# inspecting agent can read it back. Grants `edit links in main menu`. Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $role = \Drupal\user\Entity\Role::load("content_editor");
  if ($role && !$role->hasPermission("edit links in main menu")) {
    $role->grantPermission("edit links in main menu");
    $role->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: content_editor granted 'edit links in main menu'"
