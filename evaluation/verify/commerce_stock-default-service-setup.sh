#!/usr/bin/env bash
# Introspection SETUP: set the default stock service to local_stock in commerce_stock config,
# for an agent to read back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("commerce_stock.service_manager")->set("default_service_id","local_stock")->save();' >/dev/null 2>&1
echo "setup: commerce_stock.service_manager default_service_id=local_stock"
