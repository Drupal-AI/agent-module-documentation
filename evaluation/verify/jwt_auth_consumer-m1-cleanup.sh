#!/usr/bin/env bash
# Introspection CLEANUP: delete the namespaced user jwtcons_blocked created by the matching
# setup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $u = user_load_by_name("jwtcons_blocked");
  if ($u) { $u->delete(); }
' >/dev/null 2>&1
echo "cleanup: user jwtcons_blocked deleted"
