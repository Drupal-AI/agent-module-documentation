#!/usr/bin/env bash
# Introspection CLEANUP: delete the tls_eval_role role. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($r = Role::load("tls_eval_role")) { $r->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: role tls_eval_role removed"
