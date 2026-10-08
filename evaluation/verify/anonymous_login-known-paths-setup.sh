#!/usr/bin/env bash
# Introspection SETUP: configure anonymous_login to force login on /members/* except /members/public.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("anonymous_login.settings")
    ->set("paths", ["/members/*", "~/members/public"])
    ->set("login_path", "/user/login")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: anonymous_login.settings paths=[/members/*, ~/members/public]"
