#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($u = user_load_by_name("bts_perm_user")) { $u->delete(); }
  if ($r = Role::load("bts_perm_role")) { $r->delete(); }
' >/dev/null 2>&1
echo "cleanup: bts_perm_user + bts_perm_role removed"
