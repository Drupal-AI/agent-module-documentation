#!/usr/bin/env bash
# Execution RESET: ensure NO account for ru_task@example.com exists, so verify FAILS until the
# agent creates it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($u = user_load_by_mail("ru_task@example.com")) { $u->delete(); }
  if ($u = user_load_by_name("ru_task@example.com")) { $u->delete(); }
' >/dev/null 2>&1
echo "reset: no account for ru_task@example.com"
