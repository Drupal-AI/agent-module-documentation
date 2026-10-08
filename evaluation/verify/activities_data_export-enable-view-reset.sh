#!/usr/bin/env bash
# Execution RESET: disable the activity_log view so verify FAILS until the agent re-enables it.
# Uses raw config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("views.view.activity_log")->set("status", FALSE)->save();' >/dev/null 2>&1
echo "reset: views.view.activity_log disabled"
