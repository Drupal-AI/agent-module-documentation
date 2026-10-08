#!/usr/bin/env bash
# Execution RESET: create a stripe_payment_element gateway csstr_xc with express-checkout on the
# cart DISABLED. Verify FAILS until express_checkout.enable_on_cart is turned on. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_payment\Entity\PaymentGateway;
  $gw = PaymentGateway::load("csstr_xc") ?: PaymentGateway::create(["id"=>"csstr_xc","label"=>"CS XC","plugin"=>"stripe_payment_element"]);
  $gw->setPluginConfiguration([
    "mode"=>"test","publishable_key"=>"pk_test_XC","secret_key"=>"sk_test_XC",
    "display_label"=>"Stripe","payment_method_types"=>["stripe_card"],
    "express_checkout"=>["enable_on_cart"=>FALSE],
  ]);
  $gw->save();
' >/dev/null 2>&1
echo "reset: csstr_xc gateway present, express_checkout.enable_on_cart=false"
