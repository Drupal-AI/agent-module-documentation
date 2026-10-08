#!/usr/bin/env bash
# Restore shipped default commerce_stock_enforcement messages. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval "$(cat <<'PHP'
  \Drupal::configFactory()->getEditable("commerce_stock_enforcement.settings")
    ->set("insufficient_stock_cart", "The maximum quantity for %name that can be ordered is %qty.")
    ->set("insufficient_stock_add_to_cart_zero_in_cart", "Sorry, we only have %qty in stock and you've asked for %qty_asked.")
    ->set("insufficient_stock_add_to_cart_quantity_in_cart", "Sorry, we only have %qty in stock and you already added %qty_o to your cart.")
    ->save();
PHP
)" >/dev/null 2>&1
echo "cleanup: commerce_stock_enforcement.settings messages restored to defaults"
