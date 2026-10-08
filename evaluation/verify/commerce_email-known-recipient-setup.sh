#!/usr/bin/env bash
# Introspection SETUP: create a commerce_email 'ce_recipient' that emails a specific address (a
# token) on order_placed. An inspecting agent should read the entity and report the 'to' address.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_email\Entity\Email;
  if ($e = Email::load("ce_recipient")) { $e->delete(); }
  Email::create([
    "id" => "ce_recipient", "label" => "CE Recipient",
    "event" => "order_placed", "targetEntityType" => "commerce_order",
    "toType" => "email", "to" => "[commerce_order:mail]",
    "subject" => "Your order [commerce_order:order-number]",
    "body" => ["value" => "<p>Thanks.</p>", "format" => "basic_html"],
    "queue" => FALSE, "status" => TRUE,
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: commerce_email ce_recipient (toType=email, to=[commerce_order:mail])"
