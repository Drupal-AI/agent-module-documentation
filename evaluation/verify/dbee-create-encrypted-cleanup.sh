#!/usr/bin/env bash
# Execution CLEANUP: delete user dbee_new. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($u = user_load_by_name("dbee_new")) { $u->delete(); }
' >/dev/null 2>&1
echo "cleanup: user dbee_new removed"
