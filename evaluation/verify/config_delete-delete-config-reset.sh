#!/usr/bin/env bash
# Execution RESET: (re)create a simple config object config_delete_task.settings so verify
# FAILS until the agent deletes it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("config_delete_task.settings")
    ->set("keep", "no")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: config_delete_task.settings exists"
