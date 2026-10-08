#!/usr/bin/env bash
# Introspection CLEANUP: remove the wtp_own_role role. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("wtp_own_role")) { $r->delete(); }
' >/dev/null 2>&1
echo "cleanup: role wtp_own_role removed"
