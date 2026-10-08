#!/usr/bin/env bash
# Execution VERIFY: PASS when the coiu-line order has an order item titled exactly
# 'COIU Manual Line'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\commerce_order\Entity\Order;
  $ids = \Drupal::entityTypeManager()->getStorage("commerce_order")->getQuery()->accessCheck(FALSE)->condition("mail","coiu-line@example.com")->execute();
  $ok = FALSE; if ($ids) { $o = Order::load(reset($ids)); if ($o) { foreach ($o->getItems() as $it) { if ($it->getTitle() === "COIU Manual Line") { $ok = TRUE; } } } }
  print ($ok ? "PASS" : "FAIL") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
