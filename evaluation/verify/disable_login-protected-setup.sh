#!/usr/bin/env bash
# Introspection SETUP: enable Disable Login protection with querystring 'entry' and secret
# 'sesame', so an inspecting agent can read the live key/value pair. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("disable_login.settings")
    ->set("disable_login", TRUE)->set("querystring", "entry")->set("secret", "sesame")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: disable_login on, querystring=entry, secret=sesame (URL /user/login?entry=sesame)"
