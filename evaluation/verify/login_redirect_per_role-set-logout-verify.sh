#!/usr/bin/env bash
# Execution VERIFY: PASS when the authenticated LOGOUT redirect URL is the front page token
# '<front>' in login_redirect_per_role.settings. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("login_redirect_per_role.settings");
  $url = $c->get("logout.authenticated.redirect_url");
  $ok = ($url === "<front>");
  print ($ok ? "PASS" : "FAIL") . " logout.authenticated.redirect_url=" . var_export($url, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
