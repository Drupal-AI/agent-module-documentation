#!/usr/bin/env bash
# Execution CLEANUP: remove the role built during the case. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($r = \Drupal\user\Entity\Role::load("ps_secrets_manager")) { $r->delete(); }
' >/dev/null 2>&1
echo "cleanup: role ps_secrets_manager removed"
