#!/usr/bin/env bash
# Execution CLEANUP: restore aggregation mode to shipped default 'cron'. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("commerce_stock_local.transactions")->set("transactions_aggregation_mode","cron")->save();' >/dev/null 2>&1
echo "cleanup: transactions_aggregation_mode restored to cron"
