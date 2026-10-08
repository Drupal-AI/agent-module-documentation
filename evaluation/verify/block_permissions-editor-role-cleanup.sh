#!/usr/bin/env bash
# Execution CLEANUP: delete the role built during the case. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($r = \Drupal\user\Entity\Role::load("bp_task_role")) { $r->delete(); }
' >/dev/null 2>&1
echo "cleanup: role bp_task_role removed"
