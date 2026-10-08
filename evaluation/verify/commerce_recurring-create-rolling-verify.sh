#!/usr/bin/env bash
# Execution VERIFY: PASS when a billing schedule 'cr_task' exists that uses the rolling plugin,
# a monthly interval (unit=month), and prepaid billing. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\commerce_recurring\Entity\BillingSchedule;
  $bs = BillingSchedule::load("cr_task");
  $plugin = $bs ? $bs->get("plugin") : "";
  $cfg = $bs ? $bs->get("configuration") : [];
  $unit = $cfg["interval"]["unit"] ?? "";
  $btype = $bs ? $bs->get("billingType") : "";
  $ok = ($bs && $plugin === "rolling" && $unit === "month" && $btype === "prepaid");
  print ($ok ? "PASS" : "FAIL") . " plugin=" . $plugin . " unit=" . $unit . " billingType=" . $btype . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
