#!/usr/bin/env bash
# Introspection SETUP: set a known User-Agent string that the Nagios status endpoint requires
# for unauthenticated monitoring requests, so an agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("nagios.settings")
    ->set("nagios.ua", "IcingaProbe42")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: nagios.settings nagios.ua=IcingaProbe42"
