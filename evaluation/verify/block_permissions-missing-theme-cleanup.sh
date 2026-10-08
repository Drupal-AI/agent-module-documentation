#!/usr/bin/env bash
# Introspection CLEANUP: delete the role created by the matching setup. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($r = \Drupal\user\Entity\Role::load("bp_locked_role")) { $r->delete(); }
' >/dev/null 2>&1
echo "cleanup: role bp_locked_role removed"
