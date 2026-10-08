#!/usr/bin/env bash
# PASS when default variation type has maximum_order_quantity trait AND field installed. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $type=\Drupal::entityTypeManager()->getStorage("commerce_product_variation_type")->load("default");
  $has_trait=$type && in_array("maximum_order_quantity",$type->getTraits(),TRUE);
  \Drupal::service("entity_field.manager")->clearCachedFieldDefinitions();
  $fields=\Drupal::service("entity_field.manager")->getFieldDefinitions("commerce_product_variation","default");
  $has_field=isset($fields["maximum_order_quantity"]);
  $ok=$has_trait && $has_field;
  print ($ok?"PASS":"FAIL")." trait=".($has_trait?"yes":"no")." field=".($has_field?"yes":"no")."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
