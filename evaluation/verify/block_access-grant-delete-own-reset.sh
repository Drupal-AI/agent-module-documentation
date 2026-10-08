#!/usr/bin/env bash
# Execution RESET: ensure role ba_delete_role exists with NO block_access permissions (so
# verify FAILS until the agent grants 'delete own basic block_content'). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("ba_delete_role")) { $r->delete(); }
  Role::create(["id" => "ba_delete_role", "label" => "BA Delete Role"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: role ba_delete_role present with no block permissions"
