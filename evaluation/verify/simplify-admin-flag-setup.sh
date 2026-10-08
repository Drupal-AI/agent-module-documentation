#!/usr/bin/env bash
# Introspection SETUP: enable the Simplify "Hide fields from admin users" override so an
# inspecting agent can detect it. Sets simplify.global:simplify_admin = TRUE and hides the
# Status control (status) on user forms so there is a concrete hidden element too.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("simplify.global")
    ->set("simplify_admin", TRUE)
    ->set("simplify_users_global", ["status"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: simplify_admin = TRUE, simplify_users_global = [status]"
