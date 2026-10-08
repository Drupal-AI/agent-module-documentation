#!/usr/bin/env bash
# Introspection CLEANUP: delete the cup_known_creator role. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("cup_known_creator")) { $r->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: role cup_known_creator removed"
