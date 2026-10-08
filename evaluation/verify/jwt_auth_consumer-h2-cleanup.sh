#!/usr/bin/env bash
# Execution CLEANUP: delete the namespaced user jwtcons_task created by the matching reset.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $u = user_load_by_name("jwtcons_task");
  if ($u) { $u->delete(); }
' >/dev/null 2>&1
echo "cleanup: user jwtcons_task deleted"
