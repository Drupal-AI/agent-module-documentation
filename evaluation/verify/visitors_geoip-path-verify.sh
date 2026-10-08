#!/usr/bin/env bash
# Execution VERIFY: PASS when geoip_path === '/var/lib/vgeoip/'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("visitors_geoip.settings")->get("geoip_path");
  print (($v === "/var/lib/vgeoip/") ? "PASS" : "FAIL")." geoip_path=".var_export($v, TRUE)."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
