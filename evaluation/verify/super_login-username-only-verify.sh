#!/usr/bin/env bash
# Execution VERIFY: PASS when login is username-only (login_type===1) AND the login title text
# is exactly 'Staff sign in'. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("super_login.settings");
  $lt = (int) $c->get("super_login.login_type");
  $title = (string) $c->get("super_login.login_title");
  $ok = ($lt === 1 && $title === "Staff sign in");
  print ($ok ? "PASS" : "FAIL") . " login_type=" . $lt . " login_title=" . var_export($title, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
