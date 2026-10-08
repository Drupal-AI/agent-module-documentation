#!/usr/bin/env bash
# Execution RESET: create a namespaced store and the account ccc_task_user@example.com with TWO open
# draft carts of the 'default' order type, so verify FAILS (2 carts) until the agent combines them.
# NOTE: this site runs email_registration, so the account username equals its email. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_store\Entity\Store;
  use Drupal\commerce_order\Entity\Order;
  use Drupal\user\Entity\User;
  $mail = "ccc_task_user@example.com";
  $stores = \Drupal::entityTypeManager()->getStorage("commerce_store")->loadByProperties(["name" => "ccc_eval_store"]);
  $store = $stores ? reset($stores) : Store::create(["type" => "online", "name" => "ccc_eval_store", "mail" => "ccc@example.com", "default_currency" => "USD", "address" => ["country_code" => "US"], "billing_countries" => ["US"]]);
  $store->save();
  $ids = \Drupal::entityQuery("user")->condition("mail", $mail)->accessCheck(FALSE)->execute();
  $u = $ids ? User::load(reset($ids)) : User::create(["name" => $mail, "mail" => $mail, "status" => 1]);
  $u->save();
  foreach (\Drupal::entityTypeManager()->getStorage("commerce_order")->loadByProperties(["uid" => $u->id()]) as $o) { $o->delete(); }
  for ($i = 0; $i < 2; $i++) {
    Order::create(["type" => "default", "store_id" => $store->id(), "uid" => $u->id(), "cart" => TRUE, "state" => "draft"])->save();
  }
  \Drupal::service("commerce_cart.cart_provider")->clearCaches();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: user ccc_task_user@example.com has 2 open draft carts (order type default)"
