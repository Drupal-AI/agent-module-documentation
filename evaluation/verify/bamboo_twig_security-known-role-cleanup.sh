#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if ($u = user_load_by_name("bts_sec_user")) { $u->delete(); }
  if ($r = Role::load("bts_sec_role")) { $r->delete(); }
' >/dev/null 2>&1
echo "cleanup: bts_sec_user + bts_sec_role removed"
