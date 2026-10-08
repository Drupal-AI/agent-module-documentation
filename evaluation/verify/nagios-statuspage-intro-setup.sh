#!/usr/bin/env bash
# Introspection SETUP: enable the Nagios status page and set a known path so an agent can read
# the live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("nagios.settings")
    ->set("nagios.statuspage.enabled", TRUE)
    ->set("nagios.statuspage.path", "nagios_intro_status")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: nagios.settings statuspage.enabled=TRUE path=nagios_intro_status"
