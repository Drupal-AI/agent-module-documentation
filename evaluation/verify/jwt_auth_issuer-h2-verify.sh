#!/usr/bin/env bash
# Execution VERIFY for "turn ON including a JWT in the login response". PASS iff
# jwt_auth_issuer.config jwt_in_login_response === TRUE. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $val = \Drupal::config("jwt_auth_issuer.config")->get("jwt_in_login_response");
  $ok = ($val === TRUE);
  print ($ok ? "PASS" : "FAIL") . " jwt_in_login_response=" . var_export($val, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
