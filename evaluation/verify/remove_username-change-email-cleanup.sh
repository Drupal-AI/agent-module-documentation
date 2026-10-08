#!/usr/bin/env bash
# Execution CLEANUP: remove both the baseline and renamed accounts. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($u = user_load_by_mail("ru_new2@example.com")) { $u->delete(); }
  if ($u = user_load_by_mail("ru_task2@example.com")) { $u->delete(); }
' >/dev/null 2>&1
echo "cleanup: ru_task2/ru_new2 accounts removed"
