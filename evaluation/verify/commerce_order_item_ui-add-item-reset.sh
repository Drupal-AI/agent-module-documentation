#!/usr/bin/env bash
# Execution RESET: (re)create an EMPTY draft commerce order (email coiu-task@example.com) with no
# order items, so verify (needs >=1 item) FAILS until the agent adds one. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_order\Entity\Order;
  $mail = "coiu-task@example.com";
  $ids = \Drupal::entityTypeManager()->getStorage("commerce_order")->getQuery()->accessCheck(FALSE)->condition("mail",$mail)->execute();
  foreach ($ids as $id) { if ($o = Order::load($id)) { foreach ($o->getItems() as $it) { $it->delete(); } $o->delete(); } }
  Order::create(["type"=>"default","state"=>"draft","store_id"=>1,"mail"=>$mail])->save();
' >/dev/null 2>&1
echo "reset: empty order mail=coiu-task@example.com (0 items)"
