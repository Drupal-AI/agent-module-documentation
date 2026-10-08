#!/usr/bin/env bash
# MEDIUM introspection setup: create a known PayPal payment gateway config entity so the
# agent can be asked to read back its plugin id, mode, and stored credentials from live
# config. Grounded in the commerce_payment_gateway config entity only (no live PayPal call).
# Restored by commerce_paypal-known-gateway-cleanup.sh.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("commerce_payment_gateway");
  if ($g = $storage->load("paypal_known")) { $g->delete(); }
  $storage->create([
    "id" => "paypal_known",
    "label" => "PayPal Known (Sandbox)",
    "plugin" => "paypal_checkout",
    "configuration" => [
      "mode" => "test",
      "payment_solution" => "smart_payment_buttons",
      "client_id" => "SB-KNOWN-CLIENT-1234567890",
      "secret" => "SB-known-secret-abcdef",
      "intent" => "capture",
    ],
    "status" => TRUE,
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: payment gateway paypal_known created (plugin=paypal_checkout, mode=test)"
