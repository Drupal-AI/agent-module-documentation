#!/usr/bin/env bash
# Execution VERIFY: PASS when the flood ban plugin is disabled (plugins.flood.enable === FALSE). 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("crowdsec.settings")->get("plugins.flood.enable");
  $ok = ($v === FALSE || $v === 0 || $v === "0");
  print ($ok ? "PASS" : "FAIL") . " flood.enable=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
