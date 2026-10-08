#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Execution VERIFY for the "build a Content view `eval_vttnd_build` whose contextual filter
# uses this module's term-name-depth argument at DEPTH 2" task.
# Prints PASS/FAIL with detail; exits 0 (pass) / 1 (fail).
# PASS requires all of:
#   view  — a View config entity `eval_vttnd_build` exists
#   base  — its base_table is node_field_data
#   arg   — some display has a contextual filter whose plugin_id is taxonomy_index_name_depth
#   depth — that argument's depth is 2
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $view = \Drupal::entityTypeManager()->getStorage("view")->load("eval_vttnd_build");
  $has_view = (bool) $view;
  $base = FALSE; $arg = FALSE; $depth = FALSE;
  if ($has_view) {
    $base = ($view->get("base_table") === "node_field_data");
    foreach ($view->get("display") as $display) {
      foreach (($display["display_options"]["arguments"] ?? []) as $a) {
        if (($a["plugin_id"] ?? "") === "taxonomy_index_name_depth") {
          $arg = TRUE;
          if ((string) ($a["depth"] ?? "") === "2") { $depth = TRUE; }
        }
      }
    }
  }
  $pass = $has_view && $base && $arg && $depth;
  print ($pass ? "PASS" : "FAIL")
    . " view=" . ($has_view?1:0) . " base=" . ($base?1:0)
    . " arg=" . ($arg?1:0) . " depth=" . ($depth?1:0) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
