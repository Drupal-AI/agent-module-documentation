#!/usr/bin/env bash
# Introspection CLEANUP: restore the Simplify admin override and user setting to install
# defaults (simplify_admin = FALSE, simplify_users_global = []), undoing the matching setup.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("simplify.global")
    ->set("simplify_admin", FALSE)
    ->set("simplify_users_global", [])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: simplify_admin = FALSE, simplify_users_global = []"
