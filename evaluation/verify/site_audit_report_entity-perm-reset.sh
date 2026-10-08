#!/usr/bin/env bash
# Execution RESET: ensure role sare_viewer does NOT exist (so it cannot yet view reports), so
# verify FAILS until the agent creates it and grants the permission. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("sare_viewer")) { $r->delete(); }
' >/dev/null 2>&1
echo "reset: role sare_viewer absent"
