#!/usr/bin/env bash
# Execution VERIFY: PASS when login_enable_browser_login === true.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("ib_dam.settings")->get("login_enable_browser_login");
  $ok = ((bool) $v === TRUE && $v !== NULL);
  print ($ok ? "PASS" : "FAIL") . " login_enable_browser_login=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
