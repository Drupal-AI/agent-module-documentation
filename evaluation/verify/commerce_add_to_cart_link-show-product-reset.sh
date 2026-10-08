#!/usr/bin/env bash
# Execution RESET: ensure the add_to_cart_link pseudo field is HIDDEN (component removed) on the
# product default view display commerce_product.default.default, so verify FAILS until the agent
# shows it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $d = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("commerce_product.default.default");
  if ($d) { $d->removeComponent("add_to_cart_link")->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: add_to_cart_link hidden on commerce_product.default.default"
