#!/usr/bin/env bash
# Introspection CLEANUP: clear the per-bundle service override (baseline). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("commerce_stock.service_manager"); $c->clear("commerce_product_variation_default_service_id")->save();' >/dev/null 2>&1
echo "cleanup: commerce_product_variation_default_service_id cleared"
