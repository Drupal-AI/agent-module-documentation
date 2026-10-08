#!/usr/bin/env bash
# Execution VERIFY: PASS when the login route is moved to 'ls-hidden-login' with noindex on.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("login_switch.settings");
  $ok = ($c->get("login_disabled") === TRUE) && ($c->get("login_route") === "ls-hidden-login") && ($c->get("login_noindex") === TRUE);
  print ($ok ? "PASS" : "FAIL") . " disabled=" . var_export($c->get("login_disabled"),TRUE) . " route=" . var_export($c->get("login_route"),TRUE) . " noindex=" . var_export($c->get("login_noindex"),TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
