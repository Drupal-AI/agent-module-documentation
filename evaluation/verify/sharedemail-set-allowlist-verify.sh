#!/usr/bin/env bash
# Execution VERIFY: PASS when the allowlist contains both required addresses. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = (string) \Drupal::config("sharedemail.settings")->get("sharedemail_allowed");
  $ok = (stripos($v, "shared-h1@example.com") !== FALSE) && (stripos($v, "team-h1@example.com") !== FALSE);
  print ($ok ? "PASS" : "FAIL") . " allowed=" . $v . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
