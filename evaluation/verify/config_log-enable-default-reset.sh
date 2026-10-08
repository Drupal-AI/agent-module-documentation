#!/usr/bin/env bash
# Execution RESET: set Config Log to log ONLY to the custom DB table (default + mail off), so
# verify FAILS until the agent also enables the "default" (watchdog) destination. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("config_log.settings")
    ->set("log_destination", ["custom" => "custom"])
    ->save();
' >/dev/null 2>&1
echo "reset: log_destination = {custom}"
