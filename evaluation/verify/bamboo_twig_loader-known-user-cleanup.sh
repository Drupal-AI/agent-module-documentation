#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($u = user_load_by_name("bts_loader_user")) { $u->delete(); }
  \Drupal::state()->delete("bamboo_loader_uid");
' >/dev/null 2>&1
echo "cleanup: user bts_loader_user + state removed"
