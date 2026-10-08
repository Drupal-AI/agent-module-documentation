#!/usr/bin/env bash
# Introspection SETUP: set the per-variation-type stock service for the default product
# variation type to local_stock, for an agent to read back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("commerce_stock.service_manager")->set("commerce_product_variation_default_service_id","local_stock")->save();' >/dev/null 2>&1
echo "setup: commerce_product_variation_default_service_id=local_stock"
