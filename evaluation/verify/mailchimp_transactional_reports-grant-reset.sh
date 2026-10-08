#!/usr/bin/env bash
# Execution RESET: (re)create role mtr_task WITHOUT the reports permission, so verify FAILS until
# the agent grants it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("mtr_task")) { $r->delete(); }
  Role::create(["id"=>"mtr_task","label"=>"MTR task"])->save();
' >/dev/null 2>&1
echo "reset: role mtr_task created without reports permission"
