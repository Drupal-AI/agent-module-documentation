#!/usr/bin/env bash
# Execution RESET: empty allowed_hosts so verify FAILS until the agent adds the host. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("media_tyler_data_insights.settings")->set("allowed_hosts", [])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: allowed_hosts=[]"
