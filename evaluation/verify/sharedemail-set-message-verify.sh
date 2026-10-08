#!/usr/bin/env bash
# Execution VERIFY: PASS when the warning message is exactly the requested text. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = (string) \Drupal::config("sharedemail.settings")->get("sharedemail_msg");
  $want = "This email is shared by more than one account.";
  $ok = (trim($v) === $want);
  print ($ok ? "PASS" : "FAIL") . " msg=" . $v . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
