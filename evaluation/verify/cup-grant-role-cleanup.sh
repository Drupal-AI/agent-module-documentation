#!/usr/bin/env bash
# Execution CLEANUP: delete role cup_task_role. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("cup_task_role")) { $r->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: role cup_task_role removed"
