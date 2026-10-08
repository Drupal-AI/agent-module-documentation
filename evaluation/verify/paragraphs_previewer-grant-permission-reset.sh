#!/usr/bin/env bash
# Execution RESET: create/keep the role pp_reviewer and make sure it does NOT hold
# "view any paragraphs previewer", so verify FAILS until the agent grants it. Idempotent.
# Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $role = Role::load("pp_reviewer");
  if (!$role) { $role = Role::create(["id" => "pp_reviewer", "label" => "PP Reviewer"]); }
  $role->revokePermission("view any paragraphs previewer");
  $role->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: role pp_reviewer exists without view any paragraphs previewer"
