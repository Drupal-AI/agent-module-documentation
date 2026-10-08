#!/usr/bin/env bash
# Execution VERIFY: PASS when pipeline iow_task exists and contains an imageapi_optimize_webp
# processor configured at quality 80. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("imageapi_optimize.pipeline.iow_task");
  if ($c->isNew()) { print "FAIL no-pipeline\n"; return; }
  $procs = $c->get("processors") ?: [];
  $found = FALSE; $q = NULL;
  foreach ($procs as $p) {
    if (($p["id"] ?? "") === "imageapi_optimize_webp") { $found = TRUE; $q = $p["data"]["quality"] ?? NULL; }
  }
  $ok = $found && ((int) $q === 80);
  print ($ok ? "PASS" : "FAIL") . " webp_processor=" . var_export($found, TRUE) . " quality=" . var_export($q, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
