#!/usr/bin/env bash
# Execution VERIFY: PASS when warnings start 14 days before expiry (offset=1209600) and repeat
# daily (frequency=86400). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("user_expire.settings");
  $o = (int) $c->get("offset"); $f = (int) $c->get("frequency");
  print (($o === 1209600 && $f === 86400) ? "PASS" : "FAIL") . " offset=$o frequency=$f\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
