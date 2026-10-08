#!/usr/bin/env bash
# Execution VERIFY: PASS when prlp.settings login_destination === '/user/%user'. exit 0 / 1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("prlp.settings")->get("login_destination");
  $ok = ($v === "/user/%user");
  print ($ok ? "PASS" : "FAIL") . " login_destination=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
