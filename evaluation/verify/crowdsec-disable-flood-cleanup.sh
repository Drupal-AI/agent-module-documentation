#!/usr/bin/env bash
# Introspection CLEANUP: re-enable the flood ban plugin (shipped default enable=true). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("crowdsec.settings")
    ->set("plugins.flood.enable", TRUE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: crowdsec.settings plugins.flood.enable=TRUE (default)"
