#!/usr/bin/env bash
# Execution VERIFY for "make jwt_auth_consumer accept a JWT for user jwtcons_task". PASS iff
# the user exists AND is active (status 1) -- exactly what JwtAuthConsumerSubscriber::validate()
# requires. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $u = user_load_by_name("jwtcons_task");
  $exists = (bool) $u;
  $active = $exists ? !$u->isBlocked() : FALSE;
  $ok = $exists && $active;
  print ($ok ? "PASS" : "FAIL") . " exists=" . var_export($exists, TRUE) . " active=" . var_export($active, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
