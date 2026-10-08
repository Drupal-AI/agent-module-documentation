#!/usr/bin/env bash
# Execution VERIFY: PASS when the authenticated role has an inactivity period of 7776000s
# (90 days) in user_expire.settings. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $r = \Drupal::config("user_expire.settings")->get("user_expire_roles") ?: [];
  $v = $r["authenticated"] ?? NULL;
  print ((int) $v === 7776000 ? "PASS" : "FAIL") . " authenticated=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
