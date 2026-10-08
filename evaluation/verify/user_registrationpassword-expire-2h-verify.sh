#!/usr/bin/env bash
# Execution VERIFY: PASS when activation-link expiry is enabled AND the timeout is 7200 seconds.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("user_registrationpassword.settings");
  $exp = $c->get("registration_ftll_expire");
  $to = $c->get("registration_ftll_timeout");
  $ok = ((bool) $exp === TRUE && (int) $to === 7200);
  print ($ok ? "PASS" : "FAIL") . " expire=" . var_export($exp, TRUE) . " timeout=" . var_export($to, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
