#!/usr/bin/env bash
# Execution VERIFY: PASS when an imageapi_optimize_pipeline config entity "iaogd_task" exists
# and contains at least one processor whose plugin id is "imageapi_optimize_gd". Prints
# PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\imageapi_optimize\Entity\ImageAPIOptimizePipeline;
  $e = ImageAPIOptimizePipeline::load("iaogd_task");
  $ok = FALSE; $q = "none";
  if ($e) {
    foreach ($e->get("processors") as $p) {
      if (($p["id"] ?? NULL) === "imageapi_optimize_gd") {
        $ok = TRUE; $q = $p["data"]["quality"] ?? "unset";
      }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " pipeline=" . ($e ? "present" : "absent") . " gd_quality=" . $q . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
