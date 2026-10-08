#!/usr/bin/env bash
# Introspection CLEANUP: delete the ci_known2 invoice type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_invoice\Entity\InvoiceType;
  if ($t = InvoiceType::load("ci_known2")) { $t->delete(); }
' >/dev/null 2>&1
echo "cleanup: commerce_invoice_type ci_known2 removed"
