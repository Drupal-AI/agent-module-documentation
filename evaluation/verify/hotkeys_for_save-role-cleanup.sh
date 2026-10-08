#!/usr/bin/env bash
# Introspection CLEANUP: delete the hfs_role role. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("hfs_role")) { $r->delete(); }
' >/dev/null 2>&1
echo "cleanup: role hfs_role removed"
