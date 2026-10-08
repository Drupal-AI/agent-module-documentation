#!/usr/bin/env bash
# Execution VERIFY: PASS when user_redirect.settings has logout.authenticated.redirect_url ==
# / (front page). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("user_redirect.settings")->get("logout.authenticated.redirect_url");
  $ok = ($v === "/");
  print ($ok ? "PASS" : "FAIL") . " logout.authenticated.redirect_url=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
