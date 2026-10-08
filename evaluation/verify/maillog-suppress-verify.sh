#!/usr/bin/env bash
# Execution VERIFY: PASS when maillog is configured to NOT deliver mail (send=false).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $send = \Drupal::config("maillog.settings")->get("send");
  $ok = ((bool) $send === FALSE);
  print ($ok ? "PASS" : "FAIL") . " send=" . var_export($send, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
