#!/usr/bin/env bash
# Execution VERIFY: PASS when swiper_formatter_ckeditor is enabled (present in core.extension).
# Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $w = \Drupal::config("core.extension")->get("module.swiper_formatter_ckeditor");
  $ok = ($w !== NULL);
  print ($ok ? "PASS" : "FAIL") . " weight=" . var_export($w, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
