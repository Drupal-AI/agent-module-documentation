#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("salesforce_logger.settings")->set("log_push_success",false)->save();' >/dev/null 2>&1
echo "cleanup: log_push_success restored to false"
