#!/usr/bin/env bash
# Execution VERIFY: PASS when better_passwords.settings length === 12. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("better_passwords.settings")->get("length");
  $ok = ((int) $v === 12);
  print ($ok ? "PASS" : "FAIL") . " length=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
