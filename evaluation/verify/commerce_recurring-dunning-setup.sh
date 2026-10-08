#!/usr/bin/env bash
# Introspection SETUP: create a billing schedule 'cr_dunning' with a custom dunning retry
# schedule [2,4,6] and an unpaidSubscriptionState of 'expired' (non-default), so an agent can
# read back what happens to a subscription after payment retries are exhausted. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\commerce_recurring\Entity\BillingSchedule;
  if (!BillingSchedule::load("cr_dunning")) {
    BillingSchedule::create([
      "id" => "cr_dunning", "label" => "CR Dunning", "displayLabel" => "CR Dunning",
      "billingType" => "prepaid", "plugin" => "rolling",
      "configuration" => ["interval" => ["number" => 1, "unit" => "month"], "trial_interval" => []],
      "prorater" => "full_price", "proraterConfiguration" => [],
      "retrySchedule" => [2, 4, 6], "unpaidSubscriptionState" => "expired",
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: billing schedule cr_dunning (retrySchedule=[2,4,6], unpaidSubscriptionState=expired)"
