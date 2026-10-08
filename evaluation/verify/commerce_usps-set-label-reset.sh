#!/usr/bin/env bash
# Execution RESET: ensure store cusps_store and a USPS shipping method cusps_label exist with a
# PLACEHOLDER rate_label ('TBD placeholder'), so verify FAILS until the agent sets the real
# label. Idempotent. Exit 0.
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
  if ($e = $ms->loadByProperties(["name" => "cusps_label"])) { $ms->delete($e); }
  ShippingMethod::create(["stores" => [$store->id()], "name" => "cusps_label", "status" => 1,
    "plugin" => ["target_plugin_id" => "usps", "target_plugin_configuration" => [
      "rate_label" => "TBD placeholder",
      "api_information" => ["client_id" => "", "secret" => "", "mode" => "test"],
    ]]])->save();
' >/dev/null 2>&1
echo "reset: cusps_label present with placeholder rate_label"
