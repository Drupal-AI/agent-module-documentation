#!/usr/bin/env bash
# Live-state verification for the "reSmush.it pipeline with quality 90" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Grounded on the PIPELINE CONFIG (not a live optimize call to the reSmush.it API):
#   ent  — an imageapi_optimize_pipeline config entity id eval_resmushit_strict exists
#   proc — it contains a processor with id "resmushit" whose data.quality == 90
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $ent = FALSE; $proc = FALSE; $detail = "";
  $cfg = \Drupal::config("imageapi_optimize.pipeline.eval_resmushit_strict");
  if (!$cfg->isNew()) {
    $ent = TRUE;
    $q = "none";
    foreach (($cfg->get("processors") ?: []) as $p) {
      if (($p["id"] ?? "") === "resmushit") {
        $q = $p["data"]["quality"] ?? "null";
        if ((int) ($p["data"]["quality"] ?? 0) === 90) { $proc = TRUE; }
      }
    }
    $detail = "resmushit_quality=" . $q;
  }
  $ok = $ent && $proc;
  print ($ok ? "PASS" : "FAIL") . " ent=" . ($ent?1:0) . " proc=" . ($proc?1:0) . " " . $detail . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
