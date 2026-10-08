#!/usr/bin/env bash
# Execution RESET: clear the authorised-dashboards State so verify FAILS until the agent adds the
# 'drdhard_dash' entry.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::state()->set("drd_agent.authorised", []);' >/dev/null 2>&1
echo "reset: drd_agent.authorised=[]"
