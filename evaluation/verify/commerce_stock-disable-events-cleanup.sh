#!/usr/bin/env bash
# Execution CLEANUP: restore stock_events_plugin_id to core_stock_events (shipped default). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("commerce_stock.service_manager")->set("stock_events_plugin_id","core_stock_events")->save();' >/dev/null 2>&1
echo "cleanup: stock_events_plugin_id=core_stock_events (default)"
