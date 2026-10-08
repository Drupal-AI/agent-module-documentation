#!/usr/bin/env bash
# Execution VERIFY: PASS when pipeline iow_base now contains an imageapi_optimize_webp processor.
# Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("imageapi_optimize.pipeline.iow_base");
  if ($c->isNew()) { print "FAIL no-pipeline\n"; return; }
  $procs = $c->get("processors") ?: [];
  $found = FALSE;
  foreach ($procs as $p) { if (($p["id"] ?? "") === "imageapi_optimize_webp") { $found = TRUE; } }
  print ($found ? "PASS" : "FAIL") . " processors=" . count($procs) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
