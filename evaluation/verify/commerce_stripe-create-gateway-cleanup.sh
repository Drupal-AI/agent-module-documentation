#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_payment\Entity\PaymentGateway;
  if ($gw = PaymentGateway::load("csstr_hard")) { $gw->delete(); }
' >/dev/null 2>&1
echo "cleanup: csstr_hard removed"
