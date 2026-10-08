#!/usr/bin/env bash
# Introspection CLEANUP: restore Nagios status page shipped defaults (path 'nagios',
# enabled false). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("nagios.settings")
    ->set("nagios.statuspage.enabled", FALSE)
    ->set("nagios.statuspage.path", "nagios")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: nagios status page restored to defaults (path 'nagios', enabled false)"
