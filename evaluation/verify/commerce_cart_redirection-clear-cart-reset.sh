#!/usr/bin/env bash
# Execution RESET: write commerce_cart_redirection.settings with clear_cart_before_add=FALSE
# (redirect to checkout for the default bundle) so verify FAILS until the agent enables the
# single-item "clear cart before add" behavior. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("commerce_cart_redirection.settings");
  $c->set("product_bundles", ["default" => "default"])
    ->set("negate_product_bundles", FALSE)
    ->set("redirection_route_path", "checkout")
    ->set("redirection_route_path_other", "")
    ->set("clear_cart_before_add", FALSE)
    ->set("add_to_cart_replacement_text", "")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: clear_cart_before_add=FALSE"
