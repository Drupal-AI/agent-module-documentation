#!/usr/bin/env bash
# Introspection SETUP: write a known commerce_cart_redirection.settings whose add-to-cart
# button replacement text is "Buy ticket now" for the default variation bundle. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("commerce_cart_redirection.settings");
  $c->set("product_bundles", ["default" => "default"])
    ->set("negate_product_bundles", FALSE)
    ->set("redirection_route_path", "checkout")
    ->set("redirection_route_path_other", "")
    ->set("clear_cart_before_add", FALSE)
    ->set("add_to_cart_replacement_text", "Buy ticket now")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: add_to_cart_replacement_text=Buy ticket now"
