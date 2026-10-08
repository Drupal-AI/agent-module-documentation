#!/usr/bin/env bash
# Execution RESET: ensure role ebp_task_role exists WITHOUT the node.article bundle permission,
# so verify FAILS until the agent grants it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if (!Role::load("ebp_task_role")) {
    Role::create(["id" => "ebp_task_role", "label" => "EBP Task Role"])->save();
  }
  $r = Role::load("ebp_task_role");
  $r->revokePermission("entity_bundle_permissions access node article")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: role ebp_task_role present WITHOUT the article bundle permission"
