#!/usr/bin/env bash
# Execution VERIFY: PASS when matomo_reports_allowed_sites is exactly "3,7".
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("matomo_reports.matomoreportssettings")->get("matomo_reports_allowed_sites");
  $ok = ($v === "3,7");
  print ($ok ? "PASS" : "FAIL") . " allowed_sites=" . var_export($v,true) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
