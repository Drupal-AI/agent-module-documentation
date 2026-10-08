#!/usr/bin/env bash
# Introspection SETUP: grant a KNOWN role the module permission so an inspecting agent can
# read it back. Grants `administer noreqnewpass` to the content_editor role. Idempotent.
# Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $role = \Drupal\user\Entity\Role::load("content_editor");
  if ($role && !$role->hasPermission("administer noreqnewpass")) {
    $role->grantPermission("administer noreqnewpass");
    $role->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: content_editor granted 'administer noreqnewpass'"
