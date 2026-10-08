#!/usr/bin/env bash
# Execution RESET for "grant content_editor the 'edit links in main menu' permission" task:
# ensure the content_editor role exists but does NOT hold `edit links in main menu`, so verify
# FAILs until the agent grants it. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $role = \Drupal\user\Entity\Role::load("content_editor");
  if ($role && $role->hasPermission("edit links in main menu")) {
    $role->revokePermission("edit links in main menu");
    $role->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: content_editor lacks 'edit links in main menu'"
