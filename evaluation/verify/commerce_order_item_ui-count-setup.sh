#!/usr/bin/env bash
# Introspection SETUP: create a draft commerce order (customer email coiu-known@example.com) with
# exactly 2 order items, so an agent can inspect the live order and count its line items. The
# order-item admin UI (commerce_order_item_ui) manages exactly these. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_order\Entity\Order;
  use Drupal\commerce_order\Entity\OrderItem;
  use Drupal\commerce_price\Price;
  $mail = "coiu-known@example.com";
  $ids = \Drupal::entityTypeManager()->getStorage("commerce_order")->getQuery()->accessCheck(FALSE)->condition("mail",$mail)->execute();
  foreach ($ids as $id) { if ($o = Order::load($id)) { foreach ($o->getItems() as $it) { $it->delete(); } $o->delete(); } }
  $o = Order::create(["type"=>"default","state"=>"draft","store_id"=>1,"mail"=>$mail]);
  $o->save();
  foreach (["COIU Known A","COIU Known B"] as $t) {
    $oi = OrderItem::create(["type"=>"default","title"=>$t,"quantity"=>1,"unit_price"=>new Price("5.00","USD")]);
    $oi->save(); $o->addItem($oi);
  }
  $o->save();
' >/dev/null 2>&1
echo "setup: order mail=coiu-known@example.com has 2 order items"
