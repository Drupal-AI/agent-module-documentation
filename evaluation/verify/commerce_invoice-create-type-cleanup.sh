#!/usr/bin/env bash
# Execution CLEANUP: delete the ci_proforma invoice type created by the agent. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_invoice\Entity\InvoiceType;
  if ($t = InvoiceType::load("ci_proforma")) { $t->delete(); }
' >/dev/null 2>&1
echo "cleanup: commerce_invoice_type ci_proforma removed"
