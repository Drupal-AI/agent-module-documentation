#!/usr/bin/env bash
# Execution VERIFY: PASS when pipeline iowr_task exists and contains an imageapi_optimize_webp
# processor. Exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("imageapi_optimize.pipeline.iowr_task");
  if ($c->isNew()) { print "FAIL no-pipeline\n"; return; }
  $found = FALSE;
  foreach (($c->get("processors") ?: []) as $p) { if (($p["id"] ?? "") === "imageapi_optimize_webp") { $found = TRUE; } }
  print ($found ? "PASS" : "FAIL") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
