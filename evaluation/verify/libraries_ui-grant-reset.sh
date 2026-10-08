#!/usr/bin/env bash
# Execution RESET: (re)create role libraries_ui_task_role WITHOUT the 'access libraries_ui' permission,
# so verify FAILS until the agent grants it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("libraries_ui_task_role") ?: Role::create(["id" => "libraries_ui_task_role", "label" => "Libraries UI task role"]);
  $r->revokePermission("access libraries_ui")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: role libraries_ui_task_role present without 'access libraries_ui'"
