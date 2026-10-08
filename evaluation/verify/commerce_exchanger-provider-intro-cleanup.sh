#!/usr/bin/env bash
# Introspection CLEANUP: delete the ce_ecb_intro exchange-rates config entity. Restores
# baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_exchanger\Entity\ExchangeRates;
  if ($e = ExchangeRates::load("ce_ecb_intro")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ce_ecb_intro removed"
