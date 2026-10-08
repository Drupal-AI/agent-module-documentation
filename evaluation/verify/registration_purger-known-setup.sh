#!/usr/bin/env bash
# Introspection SETUP: enable purge_registration_on_update (non-default) in registration_purger.settings.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("registration_purger.settings")
    ->set("purge_registration_on_update", TRUE)->save();
' >/dev/null 2>&1
echo "setup: registration_purger.settings purge_registration_on_update=true"
