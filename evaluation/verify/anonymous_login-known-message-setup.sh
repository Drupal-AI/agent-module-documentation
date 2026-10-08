#!/usr/bin/env bash
# Introspection SETUP: configure a custom message and a protected path. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("anonymous_login.settings")
    ->set("paths", ["/vault"])
    ->set("login_path", "/user/login")
    ->set("message", "Please sign in to view members content.")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: anonymous_login.settings message set, paths=[/vault]"
