#!/usr/bin/env bash
# Introspection CLEANUP: clear the Config Log ignore list back to the shipped default. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("config_log.settings")
    ->set("log_ignored_config", [])
    ->set("log_ignored_config_negate", FALSE)
    ->save();
' >/dev/null 2>&1
echo "cleanup: log_ignored_config=[] (default)"
