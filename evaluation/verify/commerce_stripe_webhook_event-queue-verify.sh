#!/usr/bin/env bash
# Execution VERIFY: PASS when the queue setting === TRUE.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("commerce_stripe_webhook_event.settings")->get("queue");
  print (($v === TRUE) ? "PASS" : "FAIL")." queue=".var_export($v, TRUE)."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
