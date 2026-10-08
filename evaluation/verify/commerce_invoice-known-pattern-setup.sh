#!/usr/bin/env bash
# Introspection SETUP: create an invoice type ci_known2 bound to the credit-memo number pattern
# so the agent can report which number pattern that type uses. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_invoice\Entity\InvoiceType;
  if (!InvoiceType::load("ci_known2")) {
    InvoiceType::create([
      "id" => "ci_known2", "label" => "CI Known 2",
      "numberPattern" => "invoice_credit_memo", "workflow" => "invoice_default",
      "sendConfirmation" => FALSE,
    ])->save();
  }
' >/dev/null 2>&1
echo "setup: commerce_invoice_type ci_known2 created (numberPattern=invoice_credit_memo)"
