#!/usr/bin/env bash
# Execution VERIFY: PASS when retention_time === 86400.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = (int) \Drupal::config("commerce_stripe_webhook_event.settings")->get("retention_time");
  print (($v === 86400) ? "PASS" : "FAIL")." retention_time=".$v."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
