#!/usr/bin/env bash
# Execution RESET: ensure the ci_deposit invoice type does NOT exist so verify FAILS until the
# agent creates it (with dueDays=14). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_invoice\Entity\InvoiceType;
  if ($t = InvoiceType::load("ci_deposit")) { $t->delete(); }
' >/dev/null 2>&1
echo "reset: commerce_invoice_type ci_deposit absent"
