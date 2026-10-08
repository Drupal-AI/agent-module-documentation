#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Execution VERIFY for the "build a Content view `eval_vyf_build` whose date filter uses
# Views Year Filter's YEAR mode for the year 2020" task.
# Prints PASS/FAIL with detail; exits 0 (pass) / 1 (fail).
# PASS requires all of:
#   view  — a View config entity `eval_vyf_build` exists
#   base  — its base_table is node_field_data
#   filt  — some display has a date/datetime/search_api_date filter in year mode
#           (value.type === "date_year")
#   year  — that filter's year value (value.value, or value.min/value.max) is 2020
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $view = \Drupal::entityTypeManager()->getStorage("view")->load("eval_vyf_build");
  $has_view = (bool) $view;
  $base = FALSE; $filt = FALSE; $year = FALSE;
  if ($has_view) {
    $base = ($view->get("base_table") === "node_field_data");
    $date_plugins = ["date", "datetime", "search_api_date"];
    foreach ($view->get("display") as $display) {
      foreach (($display["display_options"]["filters"] ?? []) as $f) {
        $pid = $f["plugin_id"] ?? "";
        $type = $f["value"]["type"] ?? "";
        if (in_array($pid, $date_plugins, TRUE) && $type === "date_year") {
          $filt = TRUE;
          $v = (string) ($f["value"]["value"] ?? "");
          $min = (string) ($f["value"]["min"] ?? "");
          $max = (string) ($f["value"]["max"] ?? "");
          if ($v === "2020" || $min === "2020" || $max === "2020") { $year = TRUE; }
        }
      }
    }
  }
  $pass = $has_view && $base && $filt && $year;
  print ($pass ? "PASS" : "FAIL")
    . " view=" . ($has_view?1:0) . " base=" . ($base?1:0)
    . " filt=" . ($filt?1:0) . " year=" . ($year?1:0) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
