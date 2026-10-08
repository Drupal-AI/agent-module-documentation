#!/usr/bin/env bash
# Execution RESET: ensure role ckpr_build does NOT exist (verify fails until agent creates it
# and grants the permission). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("ckpr_build")) { $r->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: role ckpr_build absent"
