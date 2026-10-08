#!/usr/bin/env bash
# Introspection SETUP: create Authorize.net payment gateway ca_known (authorizenet_acceptjs,
# test mode) as a commerce_payment_gateway config entity (no live transaction). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("commerce_payment_gateway");
  if (!$s->load("ca_known")) {
    $s->create([
      "id" => "ca_known", "label" => "CA Known", "plugin" => "authorizenet_acceptjs",
      "configuration" => [
        "api_login" => "known_login_123", "transaction_key" => "known_txn_key",
        "client_key" => "known_client_key", "enable_credit_card_icons" => TRUE,
        "mode" => "test", "payment_method_types" => ["credit_card"],
      ],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: commerce_payment_gateway ca_known (authorizenet_acceptjs, mode=test)"
