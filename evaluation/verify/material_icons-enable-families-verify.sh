#!/usr/bin/env bash
# Execution VERIFY: PASS when material_icons.settings families includes BOTH 'outlined' and
# 'sharp'. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $f = \Drupal::config("material_icons.settings")->get("families") ?? [];
  $ok = in_array("outlined", $f, TRUE) && in_array("sharp", $f, TRUE);
  print ($ok ? "PASS" : "FAIL") . " families=" . json_encode($f) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
