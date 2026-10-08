#!/usr/bin/env bash
# HARD execution reset: remove the paypal_sandbox payment gateway so the "create a PayPal
# Checkout gateway in sandbox mode" build task starts from a missing (failing) state.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $g = \Drupal::entityTypeManager()->getStorage("commerce_payment_gateway")->load("paypal_sandbox");
  if ($g) { $g->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: payment gateway paypal_sandbox removed (if it existed)"
