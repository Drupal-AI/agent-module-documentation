#!/usr/bin/env bash
# Introspection CLEANUP: delete the coiu-known order and its items. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_order\Entity\Order;
  $ids = \Drupal::entityTypeManager()->getStorage("commerce_order")->getQuery()->accessCheck(FALSE)->condition("mail","coiu-known@example.com")->execute();
  foreach ($ids as $id) { if ($o = Order::load($id)) { foreach ($o->getItems() as $it) { $it->delete(); } $o->delete(); } }
' >/dev/null 2>&1 || true
echo "cleanup: coiu-known order removed"
