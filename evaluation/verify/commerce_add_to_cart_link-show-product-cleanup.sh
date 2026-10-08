#!/usr/bin/env bash
# Execution CLEANUP: hide add_to_cart_link again on commerce_product.default.default. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $d = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("commerce_product.default.default");
  if ($d) { $d->removeComponent("add_to_cart_link")->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: add_to_cart_link hidden on commerce_product.default.default"
