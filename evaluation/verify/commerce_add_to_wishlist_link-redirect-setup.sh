#!/usr/bin/env bash
# Introspection SETUP: enable redirect_back in commerce_add_to_cart_link.settings - the shared
# config that AddToWishlistController::action() reads to decide whether to send the shopper back
# to the referring page. Lets an agent read the live value the wishlist link obeys. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("commerce_add_to_cart_link.settings")->set("redirect_back", TRUE)->save();
' >/dev/null 2>&1
echo "setup: commerce_add_to_cart_link.settings redirect_back=true (governs wishlist link too)"
