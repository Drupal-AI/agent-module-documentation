#!/usr/bin/env bash
# Introspection SETUP: write a known commerce_cart_redirection.settings that redirects
# added products to a custom 'other' URL /ccr-thank-you. Agent must read the target back.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("commerce_cart_redirection.settings");
  $c->set("product_bundles", ["default" => "default"])
    ->set("negate_product_bundles", FALSE)
    ->set("redirection_route_path", "other")
    ->set("redirection_route_path_other", "/ccr-thank-you")
    ->set("clear_cart_before_add", FALSE)
    ->set("add_to_cart_replacement_text", "")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: commerce_cart_redirection.settings redirects to other=/ccr-thank-you"
