#!/usr/bin/env bash
# Execution CLEANUP: delete the ci_deposit invoice type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_invoice\Entity\InvoiceType;
  if ($t = InvoiceType::load("ci_deposit")) { $t->delete(); }
' >/dev/null 2>&1
echo "cleanup: commerce_invoice_type ci_deposit removed"
