#!/usr/bin/env bash
# Execution VERIFY: PASS when queue_mail is configured to queue ALL mail (queue_mail_keys = '*').
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = trim((string) \Drupal::config("queue_mail.settings")->get("queue_mail_keys"));
  $ok = ($v === "*");
  print ($ok ? "PASS" : "FAIL") . " queue_mail_keys=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
