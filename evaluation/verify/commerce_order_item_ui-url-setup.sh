#!/usr/bin/env bash
# Introspection SETUP: create an empty draft commerce order (email coiu-url@example.com) so an
# agent can locate it and derive the order-item management URL provided by commerce_order_item_ui.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_order\Entity\Order;
  $mail = "coiu-url@example.com";
  $ids = \Drupal::entityTypeManager()->getStorage("commerce_order")->getQuery()->accessCheck(FALSE)->condition("mail",$mail)->execute();
  foreach ($ids as $id) { if ($o = Order::load($id)) { foreach ($o->getItems() as $it) { $it->delete(); } $o->delete(); } }
  Order::create(["type"=>"default","state"=>"draft","store_id"=>1,"mail"=>$mail])->save();
' >/dev/null 2>&1
echo "setup: empty order mail=coiu-url@example.com created"
