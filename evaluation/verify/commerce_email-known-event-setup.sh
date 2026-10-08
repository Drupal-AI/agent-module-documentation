#!/usr/bin/env bash
# Introspection SETUP: create a commerce_email entity 'ce_known' triggered by the 'order_paid'
# event, sent to the administrator role. An inspecting agent should read the entity and report
# which Commerce event triggers it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_email\Entity\Email;
  if ($e = Email::load("ce_known")) { $e->delete(); }
  Email::create([
    "id" => "ce_known", "label" => "CE Known Receipt",
    "event" => "order_paid", "targetEntityType" => "commerce_order",
    "toType" => "role", "toRole" => "administrator",
    "subject" => "Payment received [commerce_order:order-number]",
    "body" => ["value" => "<p>Paid.</p>", "format" => "basic_html"],
    "queue" => FALSE, "status" => TRUE,
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: commerce_email ce_known (event=order_paid, toRole=administrator)"
