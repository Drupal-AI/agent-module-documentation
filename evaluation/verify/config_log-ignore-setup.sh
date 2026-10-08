#!/usr/bin/env bash
# Introspection SETUP: configure Config Log to ignore the system.* config pattern. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("config_log.settings")
    ->set("log_ignored_config", ["system.*"])
    ->set("log_ignored_config_negate", FALSE)
    ->save();
' >/dev/null 2>&1
echo "setup: config_log.settings log_ignored_config=[system.*], negate=false"
