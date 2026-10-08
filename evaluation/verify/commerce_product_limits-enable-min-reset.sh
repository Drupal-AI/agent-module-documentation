#!/usr/bin/env bash
# Execution RESET: ensure the default product variation type does NOT have the minimum_order_quantity
# trait (and its field is gone), so verify FAILS until the agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $tm = \Drupal::service("plugin.manager.commerce_entity_trait");
  $type = \Drupal::entityTypeManager()->getStorage("commerce_product_variation_type")->load("default");
  if (in_array("minimum_order_quantity", $type->getTraits(), TRUE)) {
    $trait = $tm->createInstance("minimum_order_quantity");
    $tm->uninstallTrait($trait, "commerce_product_variation", "default");
    $type->setTraits(array_values(array_diff($type->getTraits(), ["minimum_order_quantity"])));
    $type->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: default variation type has no minimum_order_quantity trait"
