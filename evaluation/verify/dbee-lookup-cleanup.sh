#!/usr/bin/env bash
# Introspection CLEANUP: delete user dbee_finder. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($u = user_load_by_name("dbee_finder")) { $u->delete(); }
' >/dev/null 2>&1
echo "cleanup: user dbee_finder removed"
