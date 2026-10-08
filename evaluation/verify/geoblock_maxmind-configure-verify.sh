#!/usr/bin/env bash
# Execution VERIFY: PASS when geoblock_maxmind.settings download_url equals the requested
# target URL. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
TARGET="https://updates.example.net/maxmind/GeoLite2-Country.tar.gz"
out=$(drush php:eval '
  $u = \Drupal::config("geoblock_maxmind.settings")->get("download_url");
  $ok = ($u === "'"$TARGET"'");
  print ($ok ? "PASS" : "FAIL") . " download_url=" . var_export($u, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
