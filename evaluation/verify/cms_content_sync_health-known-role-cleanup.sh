#!/usr/bin/env bash
# Introspection CLEANUP: delete role ccs_health_known. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("ccs_health_known")) { $r->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: role ccs_health_known removed"
