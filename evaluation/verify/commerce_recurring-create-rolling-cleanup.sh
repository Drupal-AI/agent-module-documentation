#!/usr/bin/env bash
# Execution CLEANUP: delete the cr_task billing schedule. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_recurring\Entity\BillingSchedule;
  if ($bs = BillingSchedule::load("cr_task")) { $bs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: billing schedule cr_task removed"
