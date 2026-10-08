#!/usr/bin/env bash
# Introspection SETUP: create a billing schedule 'cr_known' using the FIXED plugin with a
# POSTPAID billing type (non-default) on a monthly interval, so an inspecting agent can read
# back its billing type. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_recurring\Entity\BillingSchedule;
  if (!BillingSchedule::load("cr_known")) {
    BillingSchedule::create([
      "id" => "cr_known", "label" => "CR Known", "displayLabel" => "CR Known",
      "billingType" => "postpaid", "plugin" => "fixed",
      "configuration" => ["interval" => ["number" => 1, "unit" => "month"], "trial_interval" => [], "start_month" => 1, "start_day" => 1],
      "prorater" => "proportional", "proraterConfiguration" => [],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: billing schedule cr_known (plugin=fixed, billingType=postpaid)"
