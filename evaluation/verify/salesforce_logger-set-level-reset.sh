#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("salesforce_logger.settings")->set("log_level","salesforce.error")->save();' >/dev/null 2>&1
echo "reset: log_level=salesforce.error"
