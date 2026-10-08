#!/usr/bin/env bash
# Execution CLEANUP: turn protection off and clear the key/value (never leave login locked).
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("disable_login.settings");
  $c->set("disable_login", FALSE)->clear("querystring")->clear("secret")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: disable_login off, key/value cleared"
