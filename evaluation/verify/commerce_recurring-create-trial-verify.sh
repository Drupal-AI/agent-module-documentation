#!/usr/bin/env bash
# Execution VERIFY: PASS when a billing schedule 'cr_trial' exists whose plugin configuration
# defines a non-empty trial_interval of 14 days (number=14, unit=day). Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\commerce_recurring\Entity\BillingSchedule;
  $bs = BillingSchedule::load("cr_trial");
  $cfg = $bs ? $bs->get("configuration") : [];
  $ti = $cfg["trial_interval"] ?? [];
  $num = $ti["number"] ?? NULL;
  $unit = $ti["unit"] ?? NULL;
  $ok = ($bs && !empty($ti) && (string) $num === "14" && $unit === "day");
  print ($ok ? "PASS" : "FAIL") . " trial_number=" . var_export($num, TRUE) . " trial_unit=" . var_export($unit, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
