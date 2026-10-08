#!/usr/bin/env bash
# Execution RESET: ensure NO Stripe gateway named csstr_hard exists (verify FAILS on empty).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_payment\Entity\PaymentGateway;
  if ($gw = PaymentGateway::load("csstr_hard")) { $gw->delete(); }
' >/dev/null 2>&1
echo "reset: csstr_hard absent"
