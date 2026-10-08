#!/usr/bin/env bash
# Execution VERIFY: PASS when ckeditor_responsive_table.settings caption_side === 'bottom'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("ckeditor_responsive_table.settings")->get("caption_side");
  $ok = ($v === "bottom");
  print ($ok ? "PASS" : "FAIL") . " caption_side=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
