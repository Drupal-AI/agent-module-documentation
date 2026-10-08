#!/usr/bin/env bash
# Execution CLEANUP: delete both etc_role_src and etc_role_dst. Restores baseline.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  // Reset the storage static cache first: a role modified by another process can
  // otherwise be returned stale and the delete silently does nothing.
  \Drupal::entityTypeManager()->getStorage("user_role")->resetCache();
  foreach (["etc_role_src", "etc_role_dst"] as $id) {
    if ($r = Role::load($id)) { $r->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: roles etc_role_src and etc_role_dst removed"
