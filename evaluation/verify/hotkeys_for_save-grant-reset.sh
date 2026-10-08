#!/usr/bin/env bash
# Execution RESET: ensure role hfs_target does NOT exist (verify FAILS on empty). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("hfs_target")) { $r->delete(); }
' >/dev/null 2>&1
echo "reset: role hfs_target absent"
