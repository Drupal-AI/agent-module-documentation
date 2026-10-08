#!/usr/bin/env bash
# Execution VERIFY: PASS when a price list item exists under price list cpl_item_list for the
# CPL-TASK-VAR variation with price number 24.50. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ls = \Drupal::entityTypeManager()->getStorage("commerce_pricelist")->loadByProperties(["name"=>"cpl_item_list"]);
  $vs = \Drupal::entityTypeManager()->getStorage("commerce_product_variation")->loadByProperties(["sku"=>"CPL-TASK-VAR"]);
  $ok = FALSE; $found = "none";
  if ($ls && $vs) {
    $l = reset($ls); $v = reset($vs);
    $items = \Drupal::entityTypeManager()->getStorage("commerce_pricelist_item")->loadByProperties(["price_list_id"=>$l->id(),"purchasable_entity"=>$v->id()]);
    foreach ($items as $it) {
      $p = $it->getPrice();
      $found = $p ? $p->getNumber() : "null";
      if ($p && (float) $p->getNumber() === 24.50) { $ok = TRUE; }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " price=" . $found . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
