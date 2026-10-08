#!/usr/bin/env bash
# Execution RESET: ensure NO billing schedule 'cr_task' exists, so verify FAILS until the agent
# creates it. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_recurring\Entity\BillingSchedule;
  if ($bs = BillingSchedule::load("cr_task")) { $bs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: billing schedule cr_task absent"
