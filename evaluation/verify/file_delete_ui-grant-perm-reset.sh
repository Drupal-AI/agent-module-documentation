#!/usr/bin/env bash
# Execution RESET: (re)create the role file_delete_ui_deleter WITHOUT the 'delete any file'
# permission, so verify FAILS until the agent grants it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("file_delete_ui_deleter")) { $r->delete(); }
  Role::create(["id" => "file_delete_ui_deleter", "label" => "File Delete UI Deleter"])->save();
' >/dev/null 2>&1
echo "reset: role file_delete_ui_deleter exists without 'delete any file'"
