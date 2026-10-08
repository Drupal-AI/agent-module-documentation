#!/usr/bin/env bash
# Execution RESET/CLEANUP: revoke 'export contact form messages' from the authenticated role
# so verify FAILS on baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("authenticated")) { $r->revokePermission("export contact form messages"); $r->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: authenticated role revoked export permission"
