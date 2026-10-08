#!/usr/bin/env bash
# Execution VERIFY: PASS when a commerce_email 'ce_admin_paid' exists, is enabled, triggers on the
# order_paid event, and is sent to users with a role (toType=role, toRole=administrator).
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\commerce_email\Entity\Email;
  $e = Email::load("ce_admin_paid");
  $event = $e ? $e->getEventId() : NULL;
  $status = $e ? $e->status() : NULL;
  $toType = $e ? $e->getToType() : NULL;
  $toRole = $e ? $e->getToRole() : NULL;
  $ok = $e && $status && ($event === "order_paid") && ($toType === "role") && ($toRole === "administrator");
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($e ? "1" : "0") . " event=" . var_export($event, TRUE) . " toType=" . var_export($toType, TRUE) . " toRole=" . var_export($toRole, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
