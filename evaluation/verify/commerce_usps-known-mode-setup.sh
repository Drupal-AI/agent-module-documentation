#!/usr/bin/env bash
# Introspection SETUP: create throwaway store cusps_store and USPS method cusps_mode with
# api_information.mode='live' so an agent can read the mode back. Idempotent. Exit 0.
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
  if ($e = $ms->loadByProperties(["name" => "cusps_mode"])) { $ms->delete($e); }
  ShippingMethod::create(["stores" => [$store->id()], "name" => "cusps_mode", "status" => 1,
    "plugin" => ["target_plugin_id" => "usps", "target_plugin_configuration" => [
      "rate_label" => "USPS",
      "api_information" => ["client_id" => "demo", "secret" => "demo", "mode" => "live"],
    ]]])->save();
' >/dev/null 2>&1
echo "setup: commerce_shipping_method cusps_mode api_information.mode=live"
