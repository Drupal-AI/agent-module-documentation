#!/usr/bin/env bash
# Introspection CLEANUP: delete the potx_translator role created by setup. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("potx_translator")) { $r->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: role potx_translator removed"
