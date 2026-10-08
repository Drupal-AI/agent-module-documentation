#!/usr/bin/env bash
# Execution RESET for "hide the Status (blocked/active) control on user account forms".
# Forces a clean WRONG baseline so verify FAILS until the agent configures Simplify: clears
# simplify.global:simplify_users_global to an empty array (nothing hidden on user forms).
# Idempotent. Rebuilds caches. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("simplify.global")
    ->set("simplify_users_global", [])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: simplify_users_global = [] (agent must hide the user status field)"
