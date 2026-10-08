#!/usr/bin/env bash
# Execution VERIFY: PASS when monitoring_mail.settings:mail is a non-empty address. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $mail = \Drupal::config("monitoring_mail.settings")->get("mail");
  $ok = is_string($mail) && strlen(trim($mail)) > 0 && strpos($mail, "@") !== FALSE;
  print ($ok ? "PASS" : "FAIL") . " mail=" . var_export($mail, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
