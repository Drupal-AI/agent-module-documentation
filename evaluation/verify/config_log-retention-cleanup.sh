#!/usr/bin/env bash
# Introspection CLEANUP: restore Config Log retention/destinations to shipped defaults. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("config_log.settings")
    ->set("logs_to_keep", 0)
    ->set("log_destination", ["custom" => "custom"])
    ->save();
' >/dev/null 2>&1
echo "cleanup: logs_to_keep=0, destinations=custom (default)"
