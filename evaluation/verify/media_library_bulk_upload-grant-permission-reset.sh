#!/usr/bin/env bash
# Execution RESET for the "grant content_editor the Image bulk-upload permission" task:
# ensure the content_editor role exists but does NOT have the dynamic permission
# `use media image bulk upload form`, so verify FAILs until the agent grants it. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $role = \Drupal\user\Entity\Role::load("content_editor");
  if ($role && $role->hasPermission("use media image bulk upload form")) {
    $role->revokePermission("use media image bulk upload form");
    $role->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: content_editor role lacks 'use media image bulk upload form'"
