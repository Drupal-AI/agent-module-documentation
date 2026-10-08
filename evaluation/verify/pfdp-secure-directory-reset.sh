#!/usr/bin/env bash
# Execution RESET: make sure the role pfdp_task_role exists and that NO pfdp_directory entity
# with the id pfdp_task_dir (or the path /pfdp-secure) is registered, so the matching verify
# FAILS until the agent creates it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\pfdp\Entity\DirectoryEntity;
  use Drupal\user\Entity\Role;
  if (!Role::load("pfdp_task_role")) { Role::create(["id" => "pfdp_task_role", "label" => "PFDP Task Role"])->save(); }
  foreach (DirectoryEntity::loadMultiple() as $d) {
    if ($d->id() === "pfdp_task_dir" || $d->path === "/pfdp-secure") { $d->delete(); }
  }
  print "exists=" . var_export((bool) DirectoryEntity::load("pfdp_task_dir"), TRUE) . "\n";
' 2>/dev/null
echo "reset: pfdp_task_role present, no /pfdp-secure directory registered"
