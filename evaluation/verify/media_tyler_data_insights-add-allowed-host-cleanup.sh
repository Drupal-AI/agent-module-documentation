#!/usr/bin/env bash
# Execution CLEANUP: restore empty allowed_hosts baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("media_tyler_data_insights.settings")->set("allowed_hosts", [])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: allowed_hosts reset to []"
