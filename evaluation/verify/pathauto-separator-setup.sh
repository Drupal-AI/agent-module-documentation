#!/usr/bin/env bash
# Introspection SETUP: set the Pathauto word separator to a KNOWN non-default value "_"
# (underscore) so an inspecting agent can read it back. Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("pathauto.settings")->set("separator", "_")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: pathauto.settings separator set to _ (underscore)"
