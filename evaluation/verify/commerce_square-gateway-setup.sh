#!/usr/bin/env bash
# Introspection SETUP: create a Square payment gateway csq_known (mode test) with a KNOWN
# test location id, so an agent can read it back from the gateway config entity.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_payment\Entity\PaymentGateway;
  if (!PaymentGateway::load("csq_known")) {
    PaymentGateway::create([
      "id" => "csq_known", "label" => "Square Known", "plugin" => "square", "status" => TRUE,
      "configuration" => [
        "mode" => "test", "test_location_id" => "L_TEST_KNOWN",
        "live_location_id" => "", "enable_credit_card_icons" => TRUE,
      ],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: payment gateway csq_known (square) test_location_id=L_TEST_KNOWN"
