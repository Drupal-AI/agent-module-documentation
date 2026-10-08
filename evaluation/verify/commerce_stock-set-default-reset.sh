#!/usr/bin/env bash
# Execution RESET: force the default stock service to always_in_stock so verify FAILS until the
# agent switches it to local_stock. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("commerce_stock.service_manager")->set("default_service_id","always_in_stock")->save();' >/dev/null 2>&1
echo "reset: default_service_id=always_in_stock"
