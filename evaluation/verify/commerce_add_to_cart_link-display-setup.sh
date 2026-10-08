#!/usr/bin/env bash
# Introspection SETUP: show the add_to_cart_link pseudo field on the product VARIATION default
# view display (commerce_product_variation.default.default), so an agent can find which display
# renders the add-to-cart link. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $d = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("commerce_product_variation.default.default");
  if ($d) { $d->setComponent("add_to_cart_link", ["weight" => 10, "region" => "content"])->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: add_to_cart_link shown on commerce_product_variation.default.default"
