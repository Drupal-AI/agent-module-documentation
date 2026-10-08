#!/usr/bin/env bash
# Delete role unp_known_role. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("unp_known_role")) { $r->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: role unp_known_role removed"
