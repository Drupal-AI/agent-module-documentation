#!/usr/bin/env bash
# Execution VERIFY: PASS when protection is enabled with querystring 'gate' and secret 'openup'.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("disable_login.settings");
  $on = (bool) $c->get("disable_login");
  $qs = (string) $c->get("querystring");
  $sec = (string) $c->get("secret");
  $ok = ($on && $qs === "gate" && $sec === "openup");
  print ($ok ? "PASS" : "FAIL") . " disable_login=" . var_export($on, TRUE) . " querystring=" . var_export($qs, TRUE) . " secret=" . var_export($sec, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
