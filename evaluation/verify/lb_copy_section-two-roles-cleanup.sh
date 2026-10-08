#!/usr/bin/env bash
# Introspection CLEANUP: delete the lbcs_can and lbcs_cannot roles. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (["lbcs_can","lbcs_cannot"] as $id) { if ($r = \Drupal\user\Entity\Role::load($id)) { $r->delete(); } }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: roles lbcs_can, lbcs_cannot removed"
