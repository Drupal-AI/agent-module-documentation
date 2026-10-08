#!/usr/bin/env bash
# Execution VERIFY: PASS when the exposed (truthy) set is exactly {thumbnail}.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("jsonapi_image_styles.settings")->get("image_styles") ?: [];
  $sel = array_keys(array_filter($v));
  sort($sel);
  $ok = ($sel === ["thumbnail"]);
  print ($ok ? "PASS" : "FAIL") . " selected=" . implode(",", $sel) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
