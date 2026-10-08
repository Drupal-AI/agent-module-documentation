#!/usr/bin/env bash
# Execution RESET: ensure role ccs_health_viewer does NOT exist so verify fails on empty.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("ccs_health_viewer")) { $r->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: role ccs_health_viewer absent"
