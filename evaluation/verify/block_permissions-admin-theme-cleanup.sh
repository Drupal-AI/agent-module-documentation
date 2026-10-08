#!/usr/bin/env bash
# Execution CLEANUP: delete the role used by the case. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($r = \Drupal\user\Entity\Role::load("bp_claro_role")) { $r->delete(); }
' >/dev/null 2>&1
echo "cleanup: role bp_claro_role removed"
