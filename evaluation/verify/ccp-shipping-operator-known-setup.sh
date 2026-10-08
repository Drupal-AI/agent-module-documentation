#!/usr/bin/env bash
# Introspection SETUP: create a throwaway store (ccp_eval_store) and a flat_rate shipping method
# (ccp_eval_ship) whose base condition operator is OR, with a commerce_conditions_plus Or Operator
# condition, so an agent can read the base operator back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_store\Entity\Store;
  use Drupal\commerce_shipping\Entity\ShippingMethod;
  $ss = \Drupal::entityTypeManager()->getStorage("commerce_store");
  $stores = $ss->loadByProperties(["name" => "ccp_eval_store"]);
  $store = $stores ? reset($stores) : NULL;
  if (!$store) {
    $store = Store::create([
      "type" => "online", "uid" => 1, "name" => "ccp_eval_store", "mail" => "ccp@example.com",
      "default_currency" => "USD", "timezone" => "UTC", "address" => ["country_code" => "US"],
    ]);
    $store->save();
  }
  $ms = \Drupal::entityTypeManager()->getStorage("commerce_shipping_method");
  $methods = $ms->loadByProperties(["name" => "ccp_eval_ship"]);
  $m = $methods ? reset($methods) : NULL;
  if (!$m) {
    $m = ShippingMethod::create([
      "stores" => [$store->id()], "name" => "ccp_eval_ship", "status" => 1,
      "plugin" => ["target_plugin_id" => "flat_rate", "target_plugin_configuration" => [
        "rate_label" => "Std", "rate_amount" => ["number" => "5.00", "currency_code" => "USD"], "services" => ["default"],
      ]],
    ]);
  }
  $m->set("conditions", [["target_plugin_id" => "commerce_conditions_plus_or_operator", "target_plugin_configuration" => []]]);
  $m->set("condition_operator", "OR");
  $m->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ccp_eval_ship created with condition_operator=OR"
