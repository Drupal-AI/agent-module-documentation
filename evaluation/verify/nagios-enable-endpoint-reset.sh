#!/usr/bin/env bash
# Execution RESET: ensure the Nagios status page is DISABLED and on the default path, so verify
# FAILS until the agent enables it and sets the requested path. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("nagios.settings")
    ->set("nagios.statuspage.enabled", FALSE)
    ->set("nagios.statuspage.path", "nagios")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: nagios status page disabled, path 'nagios'"
