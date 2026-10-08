#!/usr/bin/env bash
# Introspection SETUP: set Pathauto's max_length to a KNOWN non-default value 77 so an
# inspecting agent can read it back. Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("pathauto.settings")->set("max_length", 77)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: pathauto.settings max_length set to 77"
