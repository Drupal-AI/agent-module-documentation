#!/usr/bin/env bash
# Introspection SETUP: set registration mode to 'default' (VERIFICATION_DEFAULT) so an agent can
# read back the current mode. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("user_registrationpassword.settings")->set("registration","default")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: user_registrationpassword registration=default"
