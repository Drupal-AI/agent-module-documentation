#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("hfs_target")) { $r->delete(); }
' >/dev/null 2>&1
echo "cleanup: role hfs_target removed"
