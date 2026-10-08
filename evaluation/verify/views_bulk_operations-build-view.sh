#!/usr/bin/env bash
# Live-state verification for the "build an admin bulk-operations screen with VBO" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# PASS requires all of:
#   view — a View config entity `eval_vbo` exists
#   fld  — at least one display has a field with plugin id `views_bulk_operations_bulk_form`
#   act  — that VBO field enables >=1 action: selected_actions is non-empty OR a
#          "select all actions" flag (show_select_all set to always_show) is present.
#          Note: an empty selected_actions in VBO means "offer ALL registered actions",
#          so an empty list only passes when the select-all flag is explicitly on.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $view = \Drupal::entityTypeManager()->getStorage("view")->load("eval_vbo");
  $has_view = (bool) $view;
  $fld = FALSE; $act = FALSE;
  if ($has_view) {
    foreach ($view->get("display") as $display) {
      $fields = $display["display_options"]["fields"] ?? [];
      foreach ($fields as $f) {
        if (($f["plugin_id"] ?? "") === "views_bulk_operations_bulk_form") {
          $fld = TRUE;
          $selected = $f["selected_actions"] ?? [];
          $select_all = ($f["show_select_all"] ?? "") === "always_show";
          if (!empty($selected) || $select_all) { $act = TRUE; }
        }
      }
    }
  }
  $pass = $has_view && $fld && $act;
  print ($pass ? "PASS" : "FAIL")
    . " view=" . ($has_view?1:0) . " fld=" . ($fld?1:0) . " act=" . ($act?1:0) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
