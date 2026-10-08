#!/usr/bin/env bash
# Execution VERIFY: PASS when view vdf_build has a filter using plugin
# views_daterange_filters_daterange with operator 'ends_by'. Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $cfg = \Drupal::config("views.view.vdf_build");
  $displays = $cfg->get("display") ?? [];
  $ok = FALSE; $op = "none"; $plugin = "none";
  foreach ($displays as $d) {
    foreach (($d["display_options"]["filters"] ?? []) as $f) {
      if (($f["plugin_id"] ?? "") === "views_daterange_filters_daterange") {
        $plugin = $f["plugin_id"]; $op = $f["operator"] ?? "";
        if ($op === "ends_by") { $ok = TRUE; }
      }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " plugin=$plugin op=$op\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
