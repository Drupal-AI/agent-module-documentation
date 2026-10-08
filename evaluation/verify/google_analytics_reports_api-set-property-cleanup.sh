#!/usr/bin/env bash
# Execution CLEANUP: remove the property key to restore baseline (property unset). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("google_analytics_reports_api.settings")->clear("property")->save();' >/dev/null 2>&1
echo "cleanup: property key cleared"
