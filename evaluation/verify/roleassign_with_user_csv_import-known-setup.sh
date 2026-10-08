#!/usr/bin/env bash
# Introspection SETUP: configure RoleAssign so content_editor is the only assignable role, which
# the roleassign_with_user_csv_import submodule uses to filter the CSV import form's role list.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("roleassign.settings")
    ->set("roleassign_roles", ["content_editor"=>"content_editor"])->save();
' >/dev/null 2>&1
echo "setup: roleassign.settings roleassign_roles=[content_editor]"
