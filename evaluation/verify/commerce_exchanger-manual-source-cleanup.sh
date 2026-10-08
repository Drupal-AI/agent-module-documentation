#!/usr/bin/env bash
# Execution CLEANUP: remove the ce_manual_task source created during the task. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_exchanger\Entity\ExchangeRates;
  if ($e = ExchangeRates::load("ce_manual_task")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ce_manual_task removed"
