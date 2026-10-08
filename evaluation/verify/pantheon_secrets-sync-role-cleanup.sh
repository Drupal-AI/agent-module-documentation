#!/usr/bin/env bash
# Introspection CLEANUP: delete the role created by the matching setup. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($r = \Drupal\user\Entity\Role::load("ps_known_role")) { $r->delete(); }
' >/dev/null 2>&1
echo "cleanup: role ps_known_role removed"
