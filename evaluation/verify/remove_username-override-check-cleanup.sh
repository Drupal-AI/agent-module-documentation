#!/usr/bin/env bash
# Introspection CLEANUP: delete the user created by the matching setup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($u = user_load_by_mail("ru_known2@example.com")) { $u->delete(); }
' >/dev/null 2>&1
echo "cleanup: user ru_known2@example.com removed"
