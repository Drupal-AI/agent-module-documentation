#!/usr/bin/env bash
# Execution RESET: set the stock events plugin to core_stock_events so verify FAILS until the
# agent switches it to disabled_stock_events. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("commerce_stock.service_manager")->set("stock_events_plugin_id","core_stock_events")->save();' >/dev/null 2>&1
echo "reset: stock_events_plugin_id=core_stock_events"
