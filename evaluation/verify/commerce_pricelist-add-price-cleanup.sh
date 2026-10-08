#!/usr/bin/env bash
# Execution CLEANUP: delete price items, the cpl_item_list price list, and the CPL-TASK-VAR
# variation. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $ls = \Drupal::entityTypeManager()->getStorage("commerce_pricelist")->loadByProperties(["name"=>"cpl_item_list"]);
  foreach ($ls as $l) {
    foreach (\Drupal::entityTypeManager()->getStorage("commerce_pricelist_item")->loadByProperties(["price_list_id"=>$l->id()]) as $it) { $it->delete(); }
    $l->delete();
  }
  foreach (\Drupal::entityTypeManager()->getStorage("commerce_product_variation")->loadByProperties(["sku"=>"CPL-TASK-VAR"]) as $v) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: cpl_item_list, its price items, and CPL-TASK-VAR removed"
