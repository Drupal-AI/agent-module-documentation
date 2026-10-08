#!/usr/bin/env bash
# Execution VERIFY: PASS when views.view.views_tree_table_task default display uses the Views
# Tree "tree_table" style AND has non-empty main_field, parent_field, and
# display_hierarchy_column options. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("views.view.views_tree_table_task");
  $type = $c->get("display.default.display_options.style.type");
  $main = $c->get("display.default.display_options.style.options.main_field");
  $parent = $c->get("display.default.display_options.style.options.parent_field");
  $col = $c->get("display.default.display_options.style.options.display_hierarchy_column");
  $ok = ($type === "tree_table" && !empty($main) && !empty($parent) && !empty($col));
  print ($ok ? "PASS" : "FAIL") . " style=" . var_export($type, TRUE) . " main=" . var_export($main, TRUE) . " parent=" . var_export($parent, TRUE) . " col=" . var_export($col, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
