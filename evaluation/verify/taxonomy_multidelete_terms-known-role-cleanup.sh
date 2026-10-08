#!/usr/bin/env bash
# Introspection CLEANUP: delete role tmt_bulk. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("tmt_bulk")) { $r->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: role tmt_bulk removed"
