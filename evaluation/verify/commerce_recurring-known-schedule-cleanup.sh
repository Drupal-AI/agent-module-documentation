#!/usr/bin/env bash
# Introspection CLEANUP: delete the cr_known billing schedule. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_recurring\Entity\BillingSchedule;
  if ($bs = BillingSchedule::load("cr_known")) { $bs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: billing schedule cr_known removed"
