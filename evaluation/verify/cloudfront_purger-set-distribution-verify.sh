#!/usr/bin/env bash
# Execution VERIFY: PASS when cloudfront_purger.settings:distribution_id === 'E2HARDDIST999'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("cloudfront_purger.settings")->get("distribution_id");
  $ok = ($v === "E2HARDDIST999");
  print ($ok ? "PASS" : "FAIL") . " distribution_id=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
