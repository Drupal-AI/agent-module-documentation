#!/usr/bin/env bash
# Execution VERIFY: PASS when a commerce_email 'ce_confirm' exists, is enabled, triggers on the
# order_placed event, and sends to the customer via a specific email address (toType=email).
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\commerce_email\Entity\Email;
  $e = Email::load("ce_confirm");
  $event = $e ? $e->getEventId() : NULL;
  $status = $e ? $e->status() : NULL;
  $toType = $e ? $e->getToType() : NULL;
  $ok = $e && $status && ($event === "order_placed") && ($toType === "email");
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($e ? "1" : "0") . " event=" . var_export($event, TRUE) . " status=" . var_export($status, TRUE) . " toType=" . var_export($toType, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
