#!/usr/bin/env bash
# Introspection CLEANUP: uninstall the maximum_order_quantity trait from the default variation type,
# removing its field. Restores baseline (no limit traits). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $tm = \Drupal::service("plugin.manager.commerce_entity_trait");
  $type = \Drupal::entityTypeManager()->getStorage("commerce_product_variation_type")->load("default");
  if (in_array("maximum_order_quantity", $type->getTraits(), TRUE)) {
    $trait = $tm->createInstance("maximum_order_quantity");
    $tm->uninstallTrait($trait, "commerce_product_variation", "default");
    $type->setTraits(array_values(array_diff($type->getTraits(), ["maximum_order_quantity"])));
    $type->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: maximum_order_quantity trait removed from default variation type"
