#!/usr/bin/env bash
# Execution RESET: delete the social_api_manager role so verify FAILS on empty state.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("social_api_manager")) { $r->delete(); }
' >/dev/null 2>&1
echo "reset: role social_api_manager deleted"
