#!/usr/bin/env bash
# Introspection CLEANUP: delete the cecsv_exporter role created by setup. Restores baseline.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("cecsv_exporter")) { $r->delete(); }
' >/dev/null 2>&1
echo "cleanup: role cecsv_exporter removed"
