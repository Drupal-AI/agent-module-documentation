#!/usr/bin/env bash
# Execution RESET: ensure a product variation (SKU CPL-TASK-VAR) and an enabled price list
# (cpl_item_list) exist, and remove any price list item for that variation under that list, so
# verify FAILS until the agent adds a price. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_product\Entity\ProductVariation;
  use Drupal\commerce_pricelist\Entity\PriceList;
  use Drupal\commerce_price\Price;
  $vs = \Drupal::entityTypeManager()->getStorage("commerce_product_variation")->loadByProperties(["sku"=>"CPL-TASK-VAR"]);
  $v = $vs ? reset($vs) : NULL;
  if (!$v) { $v = ProductVariation::create(["type"=>"default","sku"=>"CPL-TASK-VAR","title"=>"CPL Task Variation","status"=>1,"price"=>new Price("100.00","USD")]); $v->save(); }
  $ls = \Drupal::entityTypeManager()->getStorage("commerce_pricelist")->loadByProperties(["name"=>"cpl_item_list"]);
  $l = $ls ? reset($ls) : NULL;
  if (!$l) { $l = PriceList::create(["type"=>"commerce_product_variation","name"=>"cpl_item_list","status"=>1]); $l->save(); }
  foreach (\Drupal::entityTypeManager()->getStorage("commerce_pricelist_item")->loadByProperties(["price_list_id"=>$l->id(),"purchasable_entity"=>$v->id()]) as $it) { $it->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: variation CPL-TASK-VAR + price list cpl_item_list present, no price item yet"
