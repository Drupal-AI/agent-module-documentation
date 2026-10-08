#!/usr/bin/env bash
# Execution RESET: ensure store cusps_store exists and delete any shipping method named
# cusps_task (so verify FAILS until the agent creates it). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_store\Entity\Store;
  $ss = \Drupal::entityTypeManager()->getStorage("commerce_store");
  if (!$ss->loadByProperties(["name" => "cusps_store"])) {
    Store::create(["type" => "online", "uid" => 1, "name" => "cusps_store",
      "mail" => "cusps@example.com", "default_currency" => "USD", "timezone" => "UTC",
      "address" => ["country_code" => "US"]])->save();
  }
  $ms = \Drupal::entityTypeManager()->getStorage("commerce_shipping_method");
  if ($e = $ms->loadByProperties(["name" => "cusps_task"])) { $ms->delete($e); }
' >/dev/null 2>&1
echo "reset: cusps_store present, no cusps_task shipping method"
