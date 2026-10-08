#!/usr/bin/env bash
# Execution VERIFY: PASS when private_message.settings has enable_notifications === TRUE AND
# notify_by_default === TRUE (the flags the notifier's shouldSend() requires to email by
# default). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("private_message.settings");
  $en = $c->get("enable_notifications");
  $def = $c->get("notify_by_default");
  $ok = ($en === TRUE && $def === TRUE);
  print ($ok ? "PASS" : "FAIL") . " enable_notifications=" . var_export($en, TRUE) . " notify_by_default=" . var_export($def, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
