#!/usr/bin/env bash
# Execution CLEANUP: remove the account created for ru_task@example.com. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($u = user_load_by_mail("ru_task@example.com")) { $u->delete(); }
' >/dev/null 2>&1
echo "cleanup: user ru_task@example.com removed"
