#!/usr/bin/env bash
# Execution CLEANUP: delete the libraries_ui_task_role role. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("libraries_ui_task_role")) { $r->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: role libraries_ui_task_role removed"
