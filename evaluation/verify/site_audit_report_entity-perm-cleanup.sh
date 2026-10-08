#!/usr/bin/env bash
# Execution CLEANUP: delete role sare_viewer. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("sare_viewer")) { $r->delete(); }
' >/dev/null 2>&1
echo "cleanup: role sare_viewer removed"
