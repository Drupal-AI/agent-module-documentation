#!/usr/bin/env bash
# Execution RESET: ensure Disable Login protection is OFF and its key/value cleared, so verify
# FAILS until the agent enables it with the requested pair. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("disable_login.settings");
  $c->set("disable_login", FALSE)->clear("querystring")->clear("secret")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: disable_login off, key/value cleared"
