#!/usr/bin/env bash
# Execution VERIFY: PASS when h5p.settings h5p_export === 0. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("h5p.settings")->get("h5p_export");
  print (((int)$v === 0 && $v !== NULL) ? "PASS" : "FAIL") . " h5p_export=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
