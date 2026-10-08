#!/usr/bin/env bash
# Execution VERIFY: PASS when the default product variation type has the minimum_order_quantity trait
# enabled AND the minimum_order_quantity field is installed on the bundle. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $type = \Drupal::entityTypeManager()->getStorage("commerce_product_variation_type")->load("default");
  $has_trait = $type && in_array("minimum_order_quantity", $type->getTraits(), TRUE);
  \Drupal::service("entity_field.manager")->clearCachedFieldDefinitions();
  $fields = \Drupal::service("entity_field.manager")->getFieldDefinitions("commerce_product_variation", "default");
  $has_field = isset($fields["minimum_order_quantity"]);
  $ok = $has_trait && $has_field;
  print ($ok ? "PASS" : "FAIL")." trait=".($has_trait?"yes":"no")." field=".($has_field?"yes":"no")."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
