#!/usr/bin/env bash
# Execution VERIFY: PASS when a commerce_invoice_type 'ci_proforma' exists using numberPattern
# invoice_default and workflow invoice_default. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\commerce_invoice\Entity\InvoiceType;
  $t = InvoiceType::load("ci_proforma");
  $ok = $t && $t->get("numberPattern") === "invoice_default" && $t->get("workflow") === "invoice_default";
  print (($ok) ? "PASS" : "FAIL") . " exists=" . ($t ? "1" : "0") . " numberPattern=" . ($t ? var_export($t->get("numberPattern"), TRUE) : "-") . " workflow=" . ($t ? var_export($t->get("workflow"), TRUE) : "-") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
