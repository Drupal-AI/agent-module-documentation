#!/usr/bin/env bash
# Execution VERIFY: PASS when DXPR Builder is configured to use the dxpr_builder_media modal
# browser, i.e. dxpr_builder.settings:media_browser === "dxpr_builder_media_modal". Prints
# PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("dxpr_builder.settings")->get("media_browser");
  $ok = ($v === "dxpr_builder_media_modal");
  print ($ok ? "PASS" : "FAIL") . " media_browser=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
