#!/usr/bin/env bash
# Introspection SETUP: disable the built-in 'flood' ban plugin (plugins.flood.enable=false) so an
# inspecting agent can find which ban plugin is currently off. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("crowdsec.settings")
    ->set("plugins.flood.enable", FALSE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: crowdsec.settings plugins.flood.enable=FALSE"
