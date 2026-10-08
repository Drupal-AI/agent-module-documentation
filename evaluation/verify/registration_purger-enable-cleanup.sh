#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("registration_purger.settings")
    ->set("purge_registration_on_update", FALSE)->save();
' >/dev/null 2>&1
echo "cleanup: registration_purger.settings purge_registration_on_update restored to false"
