#!/usr/bin/env bash
# MEDIUM introspection cleanup: delete the known PayPal gateway config entity to restore baseline.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $g = \Drupal::entityTypeManager()->getStorage("commerce_payment_gateway")->load("paypal_known");
  if ($g) { $g->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: payment gateway paypal_known removed"
