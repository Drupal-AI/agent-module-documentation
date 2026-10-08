#!/usr/bin/env bash
# Introspection CLEANUP: delete the csq_known payment gateway. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\commerce_payment\Entity\PaymentGateway; if ($g = PaymentGateway::load("csq_known")) { $g->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: csq_known removed"
