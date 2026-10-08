#!/usr/bin/env bash
# Execution VERIFY: PASS when config pipeline imageapi_bin_eval exists and contains a jpegoptim
# processor configured with quality 82. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("imageapi_optimize.pipeline.imageapi_bin_eval");
  $procs = $c->get("processors");
  $ok = FALSE; $q = "none";
  if (is_array($procs)) {
    foreach ($procs as $p) {
      if (($p["id"] ?? "") === "jpegoptim") {
        $q = (string) ($p["data"]["quality"] ?? "");
        if ($q === "82") { $ok = TRUE; }
      }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " jpegoptim_quality=" . $q . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
