#!/usr/bin/env bash
# Introspection SETUP: create a promotion 'cpba_plugin' using the FIXED "by amount" offer,
# scope = one product only, so an agent can read the offer plugin id + scope back. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_promotion\Entity\Promotion;
  foreach (\Drupal::entityTypeManager()->getStorage("commerce_promotion")->loadByProperties(["name"=>"cpba_plugin"]) as $e) { $e->delete(); }
  $stores = array_keys(\Drupal::entityTypeManager()->getStorage("commerce_store")->loadMultiple());
  $ots = array_keys(\Drupal::entityTypeManager()->getStorage("commerce_order_type")->loadMultiple()) ?: ["default"];
  Promotion::create([
    "name" => "cpba_plugin", "order_types" => $ots, "stores" => $stores, "status" => TRUE,
    "offer" => ["target_plugin_id" => "order_item_fixed_amount_off_by_amount",
      "target_plugin_configuration" => ["amount"=>["number"=>"7.50","currency_code"=>"USD"],"type"=>"cheapest","compare"=>"product","scope"=>"product"]],
  ])->save();
' >/dev/null 2>&1
echo "setup: promotion cpba_plugin created (order_item_fixed_amount_off_by_amount, scope=product)"
