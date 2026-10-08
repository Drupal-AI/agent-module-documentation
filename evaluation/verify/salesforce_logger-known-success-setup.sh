#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("salesforce_logger.settings")->set("log_push_success",true)->save();' >/dev/null 2>&1
echo "setup: salesforce_logger.settings log_push_success=true"
