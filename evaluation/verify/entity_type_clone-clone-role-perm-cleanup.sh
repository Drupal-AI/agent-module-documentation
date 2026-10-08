#!/usr/bin/env bash
# Introspection CLEANUP: delete the two probe roles. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  // Reset the storage static cache first: a role modified by another process can
  // otherwise be returned stale and the delete silently does nothing.
  \Drupal::entityTypeManager()->getStorage("user_role")->resetCache();
  foreach (["etc_probe_alpha", "etc_probe_beta"] as $id) {
    if ($r = Role::load($id)) { $r->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: roles etc_probe_alpha and etc_probe_beta removed"
