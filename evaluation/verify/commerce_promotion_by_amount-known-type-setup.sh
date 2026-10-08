#!/usr/bin/env bash
# Introspection SETUP: create a promotion 'cpba_known' using the percentage "by amount" offer
# targeting the MOST EXPENSIVE item, so an agent can read the offer config back. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_promotion\Entity\Promotion;
  $existing = \Drupal::entityTypeManager()->getStorage("commerce_promotion")->loadByProperties(["name"=>"cpba_known"]);
  foreach ($existing as $e) { $e->delete(); }
  $stores = array_keys(\Drupal::entityTypeManager()->getStorage("commerce_store")->loadMultiple());
  $ots = array_keys(\Drupal::entityTypeManager()->getStorage("commerce_order_type")->loadMultiple()) ?: ["default"];
  Promotion::create([
    "name" => "cpba_known", "order_types" => $ots, "stores" => $stores, "status" => TRUE,
    "offer" => ["target_plugin_id" => "order_item_percentage_off_by_amount",
      "target_plugin_configuration" => ["percentage"=>"0.25","type"=>"most_expensive","compare"=>"order_item","scope"=>"order_item"]],
  ])->save();
' >/dev/null 2>&1
echo "setup: promotion cpba_known created (order_item_percentage_off_by_amount, type=most_expensive)"
