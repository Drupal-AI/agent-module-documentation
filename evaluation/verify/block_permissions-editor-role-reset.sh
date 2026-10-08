#!/usr/bin/env bash
# Execution RESET: delete the role the agent must build. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($r = \Drupal\user\Entity\Role::load("bp_task_role")) { $r->delete(); }
' >/dev/null 2>&1
echo "reset: role bp_task_role absent"
