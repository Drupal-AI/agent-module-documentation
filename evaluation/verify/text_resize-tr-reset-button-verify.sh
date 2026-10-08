#!/usr/bin/env bash
# Execution VERIFY: PASS when text_resize.settings text_resize_reset_button is TRUE.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("text_resize.settings")->get("text_resize_reset_button");
  $ok = ($v === true || $v === 1 || $v === "1");
  print ($ok ? "PASS" : "FAIL") . " reset_button=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
