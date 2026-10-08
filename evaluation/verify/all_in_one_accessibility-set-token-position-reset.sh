#!/usr/bin/env bash
# Execution RESET (also CLEANUP): delete the config object so verify FAILS until the agent sets it. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("all_in_one_accessibility.userid.settings")->delete();' >/dev/null 2>&1
echo "reset: all_in_one_accessibility.userid.settings deleted"
