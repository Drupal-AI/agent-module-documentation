#!/usr/bin/env bash
# Execution RESET: force purge_method to 'instant' so verify fails until agent sets 'soft'. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("fastly.settings")->set("purge_method","instant")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: fastly.settings purge_method=instant"
