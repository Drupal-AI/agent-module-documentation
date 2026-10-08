#!/usr/bin/env bash
# Execution VERIFY: PASS when a fixed GBP->USD exchange rate exists in
# currency.exchanger.fixed_rates. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $rates = \Drupal::config("currency.exchanger.fixed_rates")->get("rates") ?: [];
  $found = NULL;
  foreach ($rates as $r) { if (($r["currency_code_from"] ?? "") === "GBP" && ($r["currency_code_to"] ?? "") === "USD") { $found = $r["rate"]; } }
  print ($found !== NULL ? "PASS" : "FAIL") . " GBP_USD=" . var_export($found, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
