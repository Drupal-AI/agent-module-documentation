#!/usr/bin/env bash
# Execution VERIFY: PASS when the coiu-task order has at least one order item. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\commerce_order\Entity\Order;
  $ids = \Drupal::entityTypeManager()->getStorage("commerce_order")->getQuery()->accessCheck(FALSE)->condition("mail","coiu-task@example.com")->execute();
  $n = 0; if ($ids) { $o = Order::load(reset($ids)); $n = $o ? count($o->getItems()) : 0; }
  print (($n >= 1) ? "PASS" : "FAIL") . " items=" . $n . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
