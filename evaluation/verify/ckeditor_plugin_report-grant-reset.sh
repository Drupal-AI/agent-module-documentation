#!/usr/bin/env bash
# Execution RESET: ensure role ckpr_task exists WITHOUT the report permission (verify fails
# until the agent grants it). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("ckpr_task") ?: Role::create(["id" => "ckpr_task", "label" => "CKPR Task"]);
  $r->revokePermission("view ckeditor plugin report")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: role ckpr_task present without the report permission"
