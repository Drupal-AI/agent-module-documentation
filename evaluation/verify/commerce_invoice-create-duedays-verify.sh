#!/usr/bin/env bash
# Execution VERIFY: PASS when a commerce_invoice_type 'ci_deposit' exists with dueDays === 14.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\commerce_invoice\Entity\InvoiceType;
  $t = InvoiceType::load("ci_deposit");
  $due = $t ? $t->get("dueDays") : NULL;
  $ok = $t && (int) $due === 14;
  print (($ok) ? "PASS" : "FAIL") . " exists=" . ($t ? "1" : "0") . " dueDays=" . var_export($due, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
