#!/usr/bin/env bash
# Introspection SETUP: create throwaway store cusps_store and a USPS (plugin usps) shipping
# method cusps_known with rate_label 'USPS Priority (known)' so an agent can read the label back.
# Idempotent. Exit 0. (No live USPS call is made.)
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_store\Entity\Store;
  use Drupal\commerce_shipping\Entity\ShippingMethod;
  $ss = \Drupal::entityTypeManager()->getStorage("commerce_store");
  $stores = $ss->loadByProperties(["name" => "cusps_store"]);
  $store = $stores ? reset($stores) : NULL;
  if (!$store) {
    $store = Store::create(["type" => "online", "uid" => 1, "name" => "cusps_store",
      "mail" => "cusps@example.com", "default_currency" => "USD", "timezone" => "UTC",
      "address" => ["country_code" => "US"]]);
    $store->save();
  }
  $ms = \Drupal::entityTypeManager()->getStorage("commerce_shipping_method");
  $existing = $ms->loadByProperties(["name" => "cusps_known"]);
  if ($existing) { $ms->delete($existing); }
  ShippingMethod::create(["stores" => [$store->id()], "name" => "cusps_known", "status" => 1,
    "plugin" => ["target_plugin_id" => "usps", "target_plugin_configuration" => [
      "rate_label" => "USPS Priority (known)",
      "api_information" => ["client_id" => "", "secret" => "", "mode" => "test"],
    ]]])->save();
' >/dev/null 2>&1
echo "setup: commerce_shipping_method cusps_known (plugin usps) rate_label='USPS Priority (known)'"
