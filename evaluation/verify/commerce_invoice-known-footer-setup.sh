#!/usr/bin/env bash
# Introspection SETUP: create an invoice type config entity ci_known with a known footerText so
# the agent can read it back from the live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_invoice\Entity\InvoiceType;
  if (!InvoiceType::load("ci_known")) {
    InvoiceType::create([
      "id" => "ci_known", "label" => "CI Known",
      "numberPattern" => "invoice_default", "workflow" => "invoice_default",
      "footerText" => "Thank you for your business - CIKNOWN",
      "sendConfirmation" => FALSE,
    ])->save();
  }
' >/dev/null 2>&1
echo "setup: commerce_invoice_type ci_known created (footerText='Thank you for your business - CIKNOWN')"
