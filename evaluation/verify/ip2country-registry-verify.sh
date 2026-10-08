#!/usr/bin/env bash
# Execution VERIFY: PASS when ip2country.settings rir=apnic AND update_interval=1209600 (2 wk).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c=\Drupal::config("ip2country.settings");
  $ok = ($c->get("rir")==="apnic") && ((int)$c->get("update_interval")===1209600);
  print ($ok?"PASS":"FAIL")." rir=".var_export($c->get("rir"),TRUE)." interval=".var_export($c->get("update_interval"),TRUE)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
