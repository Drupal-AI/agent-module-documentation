#!/usr/bin/env bash
# Execution CLEANUP: delete the cecsv_team role. Restores baseline.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("cecsv_team")) { $r->delete(); }
' >/dev/null 2>&1
echo "cleanup: role cecsv_team removed"
