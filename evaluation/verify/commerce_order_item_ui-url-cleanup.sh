#!/usr/bin/env bash
# Introspection CLEANUP: delete the coiu-url order. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_order\Entity\Order;
  $ids = \Drupal::entityTypeManager()->getStorage("commerce_order")->getQuery()->accessCheck(FALSE)->condition("mail","coiu-url@example.com")->execute();
  foreach ($ids as $id) { if ($o = Order::load($id)) { $o->delete(); } }
' >/dev/null 2>&1 || true
echo "cleanup: coiu-url order removed"
