#!/usr/bin/env bash
# Execution VERIFY: PASS when status_messages.status_messages:status_message_time === 10000.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("status_messages.status_messages")->get("status_message_time");
  print (((int)$v === 10000) ? "PASS" : "FAIL") . " status_message_time=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
