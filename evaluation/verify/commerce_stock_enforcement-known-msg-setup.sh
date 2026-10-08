#!/usr/bin/env bash
# Introspection SETUP: set two known custom enforcement messages for an agent to read back:
# the cart message and the add-to-cart (empty cart) message. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("commerce_stock_enforcement.settings")
    ->set("insufficient_stock_cart", "CSE only %qty of %name remain in stock.")
    ->set("insufficient_stock_add_to_cart_zero_in_cart", "CSE sorry, just %qty left (you asked for %qty_asked).")
    ->save();
' >/dev/null 2>&1
echo "setup: insufficient_stock_cart + add_to_cart_zero_in_cart set to known CSE messages"
