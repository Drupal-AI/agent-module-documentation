#!/usr/bin/env bash
# Execution RESET for "grant content_editor the 'add new links to footer menu' permission" task:
# ensure content_editor exists but does NOT hold `add new links to footer menu`, so verify FAILs
# until the agent grants it. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $role = \Drupal\user\Entity\Role::load("content_editor");
  if ($role && $role->hasPermission("add new links to footer menu")) {
    $role->revokePermission("add new links to footer menu");
    $role->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: content_editor lacks 'add new links to footer menu'"
