#!/usr/bin/env bash
# Execution VERIFY: PASS when login_history keep_user === 10. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("login_history.settings")->get("keep_user");
  print (($v === 10) ? "PASS" : "FAIL") . " keep_user=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
