#!/usr/bin/env bash
# Execution CLEANUP: restore log_destination to the shipped default (custom only). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("config_log.settings")
    ->set("log_destination", ["custom" => "custom"])->save();
' >/dev/null 2>&1
echo "cleanup: log_destination = {custom} (default)"
