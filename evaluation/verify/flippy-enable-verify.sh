#!/usr/bin/env bash
# Execution VERIFY: PASS when Flippy is enabled for the Article content type. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("flippy.settings")->get("flippy_article");
  $ok = (bool) $v;
  print ($ok ? "PASS" : "FAIL") . " flippy_article=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
