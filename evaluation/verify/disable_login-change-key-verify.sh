#!/usr/bin/env bash
# Execution VERIFY: PASS when protection is on with querystring 'pass' and secret 'letmein'.
# Prints PASS/FAIL; exit 0 / 1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("disable_login.settings");
  $ok = ((bool) $c->get("disable_login")) && ((string) $c->get("querystring") === "pass") && ((string) $c->get("secret") === "letmein");
  print ($ok ? "PASS" : "FAIL") . " querystring=" . var_export($c->get("querystring"), TRUE) . " secret=" . var_export($c->get("secret"), TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
