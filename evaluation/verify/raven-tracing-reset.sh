#!/usr/bin/env bash
# HARD execution reset: clear Raven performance-tracing settings to install defaults.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("raven.settings")
    ->set("request_tracing", FALSE)
    ->set("traces_sample_rate", NULL)
    ->set("database_tracing", FALSE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: request_tracing=false, traces_sample_rate=null, database_tracing=false"
