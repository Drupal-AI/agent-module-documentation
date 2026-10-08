#!/usr/bin/env bash
# Execution VERIFY: PASS when a commerce_exchange_rates config entity ce_manual_task exists
# and uses the 'ecb' (European Central Bank) provider plugin. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\commerce_exchanger\Entity\ExchangeRates;
  $e = ExchangeRates::load("ce_manual_task");
  $plugin = $e ? $e->get("plugin") : NULL;
  $ok = ($e && $plugin === "ecb");
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($e ? "1" : "0") . " plugin=" . var_export($plugin, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
