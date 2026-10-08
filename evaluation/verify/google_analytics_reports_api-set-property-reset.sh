#!/usr/bin/env bash
# Execution RESET: clear the property key so verify FAILS until the agent sets the requested
# GA4 property id. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("google_analytics_reports_api.settings")->clear("property")->save();' >/dev/null 2>&1
echo "reset: property key cleared"
