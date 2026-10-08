#!/usr/bin/env bash
# Execution RESET: protection ON with querystring 'key' and secret 'old', so verify FAILS until
# the agent changes them to the requested pair. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("disable_login.settings")
    ->set("disable_login", TRUE)->set("querystring", "key")->set("secret", "old")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: disable_login on, querystring=key, secret=old"
