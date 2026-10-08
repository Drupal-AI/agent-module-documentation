#!/usr/bin/env bash
# Execution VERIFY: PASS when mask_color === '#ff0000'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("pwa_extras.settings.apple")->get("mask_color");
  print ((strtolower((string)$v) === "#ff0000") ? "PASS" : "FAIL") . " mask_color=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
