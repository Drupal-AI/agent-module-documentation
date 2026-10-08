#!/usr/bin/env bash
# Execution VERIFY: PASS when social_auth.settings has user_allowed === "login" AND
# post_login === "/dashboard". Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("social_auth.settings");
  $ua = $c->get("user_allowed"); $pl = $c->get("post_login");
  $ok = ($ua === "login" && $pl === "/dashboard");
  print ($ok ? "PASS" : "FAIL") . " user_allowed=" . var_export($ua, TRUE) . " post_login=" . var_export($pl, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
