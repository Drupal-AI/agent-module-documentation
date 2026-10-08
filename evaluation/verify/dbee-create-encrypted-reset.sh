#!/usr/bin/env bash
# Execution RESET: ensure user dbee_new does NOT exist (verify FAILS until the agent creates it
# and dbee encrypts its email). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($u = user_load_by_name("dbee_new")) { $u->delete(); }
' >/dev/null 2>&1
echo "reset: user dbee_new absent"
