#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped default User-Agent ('Nagios'). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("nagios.settings")
    ->set("nagios.ua", "Nagios")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: nagios.ua restored to 'Nagios'"
