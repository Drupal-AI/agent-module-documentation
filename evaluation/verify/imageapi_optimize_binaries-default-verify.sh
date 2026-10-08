#!/usr/bin/env bash
# Execution VERIFY: PASS when imageapi_optimize.settings default_pipeline == imageapi_bin_evald
# AND that pipeline exists with an optipng processor. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $def = \Drupal::config("imageapi_optimize.settings")->get("default_pipeline");
  $procs = \Drupal::config("imageapi_optimize.pipeline.imageapi_bin_evald")->get("processors");
  $has_optipng = FALSE;
  if (is_array($procs)) { foreach ($procs as $p) { if (($p["id"] ?? "") === "optipng") { $has_optipng = TRUE; } } }
  $ok = ($def === "imageapi_bin_evald") && $has_optipng;
  print ($ok ? "PASS" : "FAIL") . " default=" . var_export($def, TRUE) . " optipng=" . var_export($has_optipng, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
