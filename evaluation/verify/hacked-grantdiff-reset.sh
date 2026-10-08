#!/usr/bin/env bash
# Execution RESET: create role hacked_diff_role WITHOUT the diff permission, so verify FAILS
# until the agent grants it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("hacked_diff_role") ?: Role::create(["id" => "hacked_diff_role", "label" => "Hacked Diff Role"]);
  $r->save();
  $r->revokePermission("view diffs of changed files");
  $r->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: role hacked_diff_role present without diff permission"
