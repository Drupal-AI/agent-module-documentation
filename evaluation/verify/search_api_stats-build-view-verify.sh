#!/usr/bin/env bash
# Execution VERIFY: PASS when a View with id 'sas_report' exists and its base_table is the
# module's search_api_stats table. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::entityTypeManager()->getStorage("view")->load("sas_report");
  $bt = $v ? $v->get("base_table") : "none";
  $ok = ($v && $bt === "search_api_stats");
  print ($ok ? "PASS" : "FAIL") . " base_table=" . $bt . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
