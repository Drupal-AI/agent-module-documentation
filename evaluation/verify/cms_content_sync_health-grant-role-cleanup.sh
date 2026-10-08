#!/usr/bin/env bash
# Execution CLEANUP: delete role ccs_health_viewer. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("ccs_health_viewer")) { $r->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: role ccs_health_viewer removed"
