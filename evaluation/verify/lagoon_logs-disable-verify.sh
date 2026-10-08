#!/usr/bin/env bash
# Execution VERIFY: PASS when lagoon_logs.settings disable is truthy (log shipping suppressed).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $d = \Drupal::config("lagoon_logs.settings")->get("disable");
  $ok = (bool) $d === TRUE || (int) $d === 1;
  print ($ok ? "PASS" : "FAIL")." disable=".var_export($d, TRUE)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
