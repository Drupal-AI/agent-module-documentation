#!/usr/bin/env bash
# Execution RESET: ensure the flood ban plugin is ENABLED (default), so verify FAILS until the agent
# disables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("crowdsec.settings")
    ->set("plugins.flood.enable", TRUE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: crowdsec.settings plugins.flood.enable=TRUE (default)"
