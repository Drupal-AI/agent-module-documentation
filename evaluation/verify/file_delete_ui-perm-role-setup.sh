#!/usr/bin/env bash
# Introspection SETUP: create a role (file_delete_ui_editor) and grant it the module's
# 'delete any file' permission, so an inspecting agent can report which role holds it.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if (!Role::load("file_delete_ui_editor")) {
    Role::create(["id" => "file_delete_ui_editor", "label" => "File Delete UI Editor"])->save();
  }
  $r = Role::load("file_delete_ui_editor");
  $r->grantPermission("delete any file")->save();
' >/dev/null 2>&1
echo "setup: role file_delete_ui_editor granted 'delete any file'"
