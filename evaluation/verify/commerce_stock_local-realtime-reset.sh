#!/usr/bin/env bash
# Execution RESET: set aggregation mode to 'cron' (default) so verify FAILS until the agent
# switches it to real-time. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("commerce_stock_local.transactions")->set("transactions_aggregation_mode","cron")->save();' >/dev/null 2>&1
echo "reset: transactions_aggregation_mode=cron"
