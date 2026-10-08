#!/usr/bin/env bash
# Introspection SETUP: set Config Log to keep 1000 rows and log to custom+default destinations,
# so an inspecting agent can read the retention limit back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("config_log.settings")
    ->set("logs_to_keep", 1000)
    ->set("log_destination", ["custom" => "custom", "default" => "default"])
    ->save();
' >/dev/null 2>&1
echo "setup: config_log.settings logs_to_keep=1000, destinations=custom+default"
