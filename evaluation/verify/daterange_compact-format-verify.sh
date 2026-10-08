#!/usr/bin/env bash
# Execution VERIFY (daterange_compact create format): PASS when a daterange_compact_format config
# entity dc_task exists with default_pattern Y-m-d. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("daterange_compact_format");
  $e = $s->load("dc_task");
  $p = $e ? $e->get("default_pattern") : "none";
  $ok = ($e && $p === "Y-m-d");
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($e ? "yes" : "no") . " default_pattern=" . var_export($p, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
