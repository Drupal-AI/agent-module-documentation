#!/usr/bin/env bash
# Introspection CLEANUP: delete roles ckpr_yes and ckpr_no. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  foreach (["ckpr_yes","ckpr_no"] as $id) { if ($r = Role::load($id)) { $r->delete(); } }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: roles ckpr_yes, ckpr_no removed"
