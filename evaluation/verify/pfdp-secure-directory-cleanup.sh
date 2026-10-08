#!/usr/bin/env bash
# Execution CLEANUP: delete the pfdp_task_dir directory entity (or anything registered for
# /pfdp-secure) and the pfdp_task_role role. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\pfdp\Entity\DirectoryEntity;
  use Drupal\user\Entity\Role;
  foreach (DirectoryEntity::loadMultiple() as $d) {
    if ($d->id() === "pfdp_task_dir" || $d->path === "/pfdp-secure") { $d->delete(); }
  }
  if ($r = Role::load("pfdp_task_role")) { $r->delete(); }
  print "cleaned\n";
' 2>/dev/null
echo "cleanup: pfdp_task_dir and pfdp_task_role removed"
