#!/usr/bin/env bash
# Execution RESET: ensure the target exchange-rates source does NOT exist, so verify FAILS
# until the agent creates it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_exchanger\Entity\ExchangeRates;
  if ($e = ExchangeRates::load("ce_manual_task")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: ce_manual_task absent"
