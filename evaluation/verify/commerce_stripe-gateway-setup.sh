#!/usr/bin/env bash
# Introspection SETUP: create a Stripe payment gateway config entity (csstr_gw) using the
# stripe_payment_element plugin in test mode with a known publishable key. Local config only,
# no Stripe API call. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_payment\Entity\PaymentGateway;
  $gw = PaymentGateway::load("csstr_gw") ?: PaymentGateway::create(["id"=>"csstr_gw","label"=>"CS Stripe","plugin"=>"stripe_payment_element"]);
  $gw->setPluginConfiguration([
    "mode"=>"test","publishable_key"=>"pk_test_CSMED123","secret_key"=>"sk_test_CSMED123",
    "display_label"=>"Stripe","payment_method_types"=>["stripe_card"],
  ]);
  $gw->save();
' >/dev/null 2>&1
echo "setup: commerce_payment_gateway.csstr_gw (stripe_payment_element, pk_test_CSMED123)"
