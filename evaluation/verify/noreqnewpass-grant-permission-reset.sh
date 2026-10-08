#!/usr/bin/env bash
# Execution RESET for the "grant content_editor the administer noreqnewpass permission"
# task: ensure the content_editor role exists but does NOT hold `administer noreqnewpass`,
# so verify FAILs until the agent grants it. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $role = \Drupal\user\Entity\Role::load("content_editor");
  if ($role && $role->hasPermission("administer noreqnewpass")) {
    $role->revokePermission("administer noreqnewpass");
    $role->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: content_editor lacks 'administer noreqnewpass'"
