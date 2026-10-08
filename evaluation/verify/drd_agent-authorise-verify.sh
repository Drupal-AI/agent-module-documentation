#!/usr/bin/env bash
# Execution VERIFY: PASS when the authorised-dashboards State array contains the key drdhard_dash.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $a = \Drupal::state()->get("drd_agent.authorised", []);
  $ok = is_array($a) && array_key_exists("drdhard_dash", $a);
  print ($ok ? "PASS" : "FAIL")." keys=".implode(",", is_array($a)?array_keys($a):[])."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
