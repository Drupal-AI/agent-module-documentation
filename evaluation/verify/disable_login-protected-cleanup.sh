#!/usr/bin/env bash
# Introspection CLEANUP: turn protection OFF and clear the key/value, restoring the shipped
# baseline (no config -> protection off). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("disable_login.settings");
  $c->set("disable_login", FALSE)->clear("querystring")->clear("secret")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: disable_login off, querystring/secret cleared"
