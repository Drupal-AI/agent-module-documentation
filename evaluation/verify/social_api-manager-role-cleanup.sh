#!/usr/bin/env bash
# Execution CLEANUP: delete the social_api_manager role. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("social_api_manager")) { $r->delete(); }
' >/dev/null 2>&1
echo "cleanup: role social_api_manager deleted"
