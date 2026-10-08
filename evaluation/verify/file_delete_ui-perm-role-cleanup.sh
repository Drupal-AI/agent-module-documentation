#!/usr/bin/env bash
# Introspection CLEANUP: delete the file_delete_ui_editor role created by setup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("file_delete_ui_editor")) { $r->delete(); }
' >/dev/null 2>&1
echo "cleanup: role file_delete_ui_editor removed"
