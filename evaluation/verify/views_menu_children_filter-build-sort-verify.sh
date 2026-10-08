#!/usr/bin/env bash
# Execution VERIFY for "build a View vmcf_task_sort using the menu-children sort handler".
# PASS when views.view.vmcf_task_sort exists and its default display has a sort whose
# plugin_id is menu_children, attached to table=node field=menu_children_sort (the module's
# real Views-data key for the sort, per views_menu_children_filter.views.inc).
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("vmcf_task_sort");
  $ok = FALSE;
  $found = "none";
  if ($v) {
    $display = $v->get("display");
    $sorts = $display["default"]["display_options"]["sorts"] ?? [];
    foreach ($sorts as $id => $sort) {
      if (($sort["plugin_id"] ?? "") === "menu_children" && ($sort["table"] ?? "") === "node" && ($sort["field"] ?? "") === "menu_children_sort") {
        $ok = TRUE;
        $found = $id;
        break;
      }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " sort=" . $found . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
