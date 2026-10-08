#!/usr/bin/env bash
# Execution VERIFY: PASS when hotjar.settings account == 7654321. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("hotjar.settings")->get("account");
  $ok = ((string) $v === "7654321");
  print ($ok ? "PASS" : "FAIL") . " account=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
