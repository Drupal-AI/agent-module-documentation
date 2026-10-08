#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  $tm=\Drupal::service("plugin.manager.commerce_entity_trait");
  $type=\Drupal::entityTypeManager()->getStorage("commerce_product_variation_type")->load("default");
  if (in_array("maximum_order_quantity",$type->getTraits(),TRUE)) {
    $t=$tm->createInstance("maximum_order_quantity"); $tm->uninstallTrait($t,"commerce_product_variation","default");
    $type->setTraits(array_values(array_diff($type->getTraits(),["maximum_order_quantity"]))); $type->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: default variation type has no maximum_order_quantity trait"
