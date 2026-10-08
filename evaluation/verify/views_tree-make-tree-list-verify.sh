#!/usr/bin/env bash
# Execution VERIFY: PASS when views.view.views_tree_task default display uses the Views Tree
# "tree" (list) style AND has non-empty main_field and parent_field options.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("views.view.views_tree_task");
  $type = $c->get("display.default.display_options.style.type");
  $main = $c->get("display.default.display_options.style.options.main_field");
  $parent = $c->get("display.default.display_options.style.options.parent_field");
  $ok = ($type === "tree" && !empty($main) && !empty($parent));
  print ($ok ? "PASS" : "FAIL") . " style=" . var_export($type, TRUE) . " main=" . var_export($main, TRUE) . " parent=" . var_export($parent, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
