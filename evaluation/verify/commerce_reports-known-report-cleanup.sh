#!/usr/bin/env bash
# Introspection CLEANUP: delete the known order report by its unique mail. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("commerce_order_report");
  foreach ($storage->loadByProperties(["mail" => "creport-known@example.test"]) as $e) { $e->delete(); }
' >/dev/null 2>&1
echo "cleanup: known commerce_order_report removed"
