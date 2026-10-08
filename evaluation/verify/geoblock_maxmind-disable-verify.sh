#!/usr/bin/env bash
# Execution VERIFY: PASS when geoblock_maxmind.settings download_url is empty (auto-download
# disabled). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $u = \Drupal::config("geoblock_maxmind.settings")->get("download_url");
  $ok = ($u === "" || $u === NULL);
  print ($ok?"PASS":"FAIL")." download_url=".var_export($u,TRUE)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
