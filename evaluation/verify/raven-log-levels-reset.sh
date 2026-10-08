#!/usr/bin/env bash
# HARD execution reset: clear the Sentry PHP DSN, environment and all error log_levels.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("raven.settings")
    ->set("client_key", NULL)
    ->set("environment", NULL)
    ->set("log_levels", ["emergency" => FALSE, "alert" => FALSE, "critical" => FALSE, "error" => FALSE, "warning" => FALSE, "notice" => FALSE, "info" => FALSE, "debug" => FALSE])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: client_key=null, environment=null, log_levels all false"
