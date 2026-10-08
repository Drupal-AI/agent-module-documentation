#!/usr/bin/env bash
# Introspection SETUP: create Authorize.net eCheck gateway ca_known2 (authorizenet_echeck)
# with api_login 'echeck_login_xyz'. commerce_payment_gateway config entity, no live txn.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("commerce_payment_gateway");
  if (!$s->load("ca_known2")) {
    $s->create([
      "id" => "ca_known2", "label" => "CA Known2", "plugin" => "authorizenet_echeck",
      "configuration" => [
        "api_login" => "echeck_login_xyz", "transaction_key" => "known2_txn_key",
        "client_key" => "known2_client_key", "mode" => "test",
        "payment_method_types" => ["authnet_echeck"],
      ],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: commerce_payment_gateway ca_known2 (authorizenet_echeck, api_login=echeck_login_xyz)"
