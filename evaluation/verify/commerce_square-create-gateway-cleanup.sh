#!/usr/bin/env bash
# Execution CLEANUP: delete csq_build. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\commerce_payment\Entity\PaymentGateway; if ($g = PaymentGateway::load("csq_build")) { $g->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: csq_build removed"
