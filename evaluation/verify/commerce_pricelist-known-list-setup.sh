#!/usr/bin/env bash
# Introspection SETUP: create an enabled price list with a distinctive name + weight so the
# agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_pricelist\Entity\PriceList;
  $e = \Drupal::entityTypeManager()->getStorage("commerce_pricelist")->loadByProperties(["name"=>"cpl_probe_list"]);
  if (!$e) { PriceList::create(["type"=>"commerce_product_variation","name"=>"cpl_probe_list","status"=>1,"weight"=>37])->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: price list cpl_probe_list (weight 37) present"
