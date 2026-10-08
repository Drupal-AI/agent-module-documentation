#!/usr/bin/env bash
# Introspection SETUP: enable the commerce_product_limits "maximum_order_quantity" trait on the
# default product variation type (installs the field + records the trait), so an inspecting agent can
# read back which limit trait is enabled. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $tm = \Drupal::service("plugin.manager.commerce_entity_trait");
  $type = \Drupal::entityTypeManager()->getStorage("commerce_product_variation_type")->load("default");
  if (!in_array("maximum_order_quantity", $type->getTraits(), TRUE)) {
    $trait = $tm->createInstance("maximum_order_quantity");
    $tm->installTrait($trait, "commerce_product_variation", "default");
    $type->setTraits(array_unique(array_merge($type->getTraits(), ["maximum_order_quantity"])));
    $type->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: default variation type has trait maximum_order_quantity"
