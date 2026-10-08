#!/usr/bin/env bash
# Live-state verification for the "build view eval_vbo_multi whose VBO field enables the
# delete AND unpublish actions" task. Prints PASS/FAIL with detail; exits 0/1.
# PASS requires all of:
#   view — a View config entity `eval_vbo_multi` exists
#   fld  — at least one display has a field with plugin id views_bulk_operations_bulk_form
#   act  — that VBO field's selected_actions is EXACTLY the set
#          {node_delete_action, node_unpublish_action}
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $view = \Drupal::entityTypeManager()->getStorage("view")->load("eval_vbo_multi");
  $has_view = (bool) $view;
  $fld = FALSE; $act = FALSE;
  if ($has_view) {
    foreach ($view->get("display") as $display) {
      foreach (($display["display_options"]["fields"] ?? []) as $f) {
        if (($f["plugin_id"] ?? "") === "views_bulk_operations_bulk_form") {
          $fld = TRUE;
          $ids = array_values(array_unique(array_filter(array_column($f["selected_actions"] ?? [], "action_id"))));
          sort($ids);
          $want = ["node_delete_action", "node_unpublish_action"];
          if ($ids === $want) { $act = TRUE; }
        }
      }
    }
  }
  $pass = $has_view && $fld && $act;
  print ($pass ? "PASS" : "FAIL")
    . " view=" . ($has_view?1:0) . " fld=" . ($fld?1:0) . " act=" . ($act?1:0) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
