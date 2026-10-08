#!/usr/bin/env bash
# Introspection CLEANUP: delete the mdb_eval_curator role created by the matching setup.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\user\Entity\Role;
  if ($role = Role::load("mdb_eval_curator")) { $role->delete(); }
' >/dev/null 2>&1

echo "cleanup: role mdb_eval_curator removed"
