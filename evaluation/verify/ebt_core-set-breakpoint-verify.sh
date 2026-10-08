#!/usr/bin/env bash
# Execution VERIFY: PASS when ebt_core.settings ebt_core_mobile_breakpoint === '500' (or 500).
# exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("ebt_core.settings")->get("ebt_core_mobile_breakpoint");
  print ((string)$v === "500" ? "PASS" : "FAIL") . " mobile_breakpoint=" . var_export($v, TRUE);
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
