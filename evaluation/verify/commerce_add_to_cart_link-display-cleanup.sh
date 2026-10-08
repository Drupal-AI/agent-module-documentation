#!/usr/bin/env bash
# Introspection CLEANUP: hide the add_to_cart_link pseudo field again on the variation default
# display (remove the component -> back to hidden default). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $d = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("commerce_product_variation.default.default");
  if ($d) { $d->removeComponent("add_to_cart_link")->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: add_to_cart_link hidden again on commerce_product_variation.default.default"
