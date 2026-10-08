#!/usr/bin/env bash
# Execution RESET: force purge_registration_on_update FALSE (shipped default) so verify fails first.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("registration_purger.settings")
    ->set("purge_registration_on_update", FALSE)->save();
' >/dev/null 2>&1
echo "reset: registration_purger.settings purge_registration_on_update=FALSE"
