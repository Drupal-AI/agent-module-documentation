#!/usr/bin/env bash
# Execution RESET: clear the Config Log ignore list so verify FAILS until the agent adds a
# user.* ignore pattern. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("config_log.settings")
    ->set("log_ignored_config", [])
    ->set("log_ignored_config_negate", FALSE)
    ->save();
' >/dev/null 2>&1
echo "reset: log_ignored_config = []"
