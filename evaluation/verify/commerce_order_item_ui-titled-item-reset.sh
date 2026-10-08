#!/usr/bin/env bash
# Execution RESET: (re)create an EMPTY draft commerce order (email coiu-line@example.com); verify
# (needs an item titled 'COIU Manual Line') FAILS until the agent adds it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_order\Entity\Order;
  $mail = "coiu-line@example.com";
  $ids = \Drupal::entityTypeManager()->getStorage("commerce_order")->getQuery()->accessCheck(FALSE)->condition("mail",$mail)->execute();
  foreach ($ids as $id) { if ($o = Order::load($id)) { foreach ($o->getItems() as $it) { $it->delete(); } $o->delete(); } }
  Order::create(["type"=>"default","state"=>"draft","store_id"=>1,"mail"=>$mail])->save();
' >/dev/null 2>&1
echo "reset: empty order mail=coiu-line@example.com (0 items)"
