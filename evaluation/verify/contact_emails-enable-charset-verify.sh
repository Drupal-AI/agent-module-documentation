#!/usr/bin/env bash
# Execution VERIFY: PASS when contact_emails.settings allow_charset_utf_8 === TRUE. Read-only.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("contact_emails.settings")->get("allow_charset_utf_8");
  print (($v === TRUE) ? "PASS" : "FAIL") . " allow_charset_utf_8=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
