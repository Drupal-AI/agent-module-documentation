#!/usr/bin/env bash
# Introspection SETUP: create one known commerce_order_report (order_report) with a distinctive
# contact email so an agent can read it back. Idempotent (delete-by-mail then insert). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("commerce_order_report");
  foreach ($storage->loadByProperties(["mail" => "creport-known@example.test"]) as $e) { $e->delete(); }
  $storage->create([
    "type" => "order_report", "order_id" => 1,
    "amount" => ["number" => "123.45", "currency_code" => "USD"],
    "mail" => "creport-known@example.test",
  ])->save();
' >/dev/null 2>&1
echo "setup: commerce_order_report (order_report) mail=creport-known@example.test created"
