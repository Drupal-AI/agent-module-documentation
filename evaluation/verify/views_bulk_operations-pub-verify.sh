#!/usr/bin/env bash
# Live-state verification for the "build view eval_vbo_pub with ONLY the publish action
# and select-all off" task. Prints PASS/FAIL with detail; exits 0 (pass) / 1 (fail).
# PASS requires all of:
#   view — a View config entity `eval_vbo_pub` exists
#   fld  — at least one display has a field with plugin id views_bulk_operations_bulk_form
#   act  — that VBO field's selected_actions is EXACTLY {node_publish_action}
#          (publish enabled, nothing else; an empty list — "offer all actions" — fails)
#   sa   — select-all is OFF: show_select_all is not "always_show"
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $view = \Drupal::entityTypeManager()->getStorage("view")->load("eval_vbo_pub");
  $has_view = (bool) $view;
  $fld = FALSE; $act = FALSE; $sa = FALSE;
  if ($has_view) {
    foreach ($view->get("display") as $display) {
      foreach (($display["display_options"]["fields"] ?? []) as $f) {
        if (($f["plugin_id"] ?? "") === "views_bulk_operations_bulk_form") {
          $fld = TRUE;
          $ids = array_values(array_filter(array_column($f["selected_actions"] ?? [], "action_id")));
          sort($ids);
          if ($ids === ["node_publish_action"]) { $act = TRUE; }
          if (($f["show_select_all"] ?? "default") !== "always_show") { $sa = TRUE; }
        }
      }
    }
  }
  $pass = $has_view && $fld && $act && $sa;
  print ($pass ? "PASS" : "FAIL")
    . " view=" . ($has_view?1:0) . " fld=" . ($fld?1:0) . " act=" . ($act?1:0) . " sa=" . ($sa?1:0) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
