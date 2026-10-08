#!/usr/bin/env bash
# Execution RESET: ensure the csq_build gateway does NOT exist, so verify FAILs until the
# agent creates a Square gateway in test mode.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\commerce_payment\Entity\PaymentGateway; if ($g = PaymentGateway::load("csq_build")) { $g->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: csq_build absent"
