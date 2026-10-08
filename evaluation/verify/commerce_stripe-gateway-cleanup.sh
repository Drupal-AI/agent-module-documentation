#!/usr/bin/env bash
# Introspection CLEANUP: remove the csstr_gw payment gateway. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_payment\Entity\PaymentGateway;
  if ($gw = PaymentGateway::load("csstr_gw")) { $gw->delete(); }
' >/dev/null 2>&1
echo "cleanup: csstr_gw removed"
