#!/usr/bin/env bash
# Execution RESET: (re)create role unp_task_role WITHOUT any unpublished permission so verify FAILS
# until the agent grants 'view article unpublished content'. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("unp_task_role")) { $r->delete(); }
  Role::create(["id"=>"unp_task_role","label"=>"UNP Task Role"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: role unp_task_role exists with no unpublished permissions"
