#!/usr/bin/env bash
# Execution VERIFY for "build a View vmcf_task using the menu-children argument handler".
# PASS when views.view.vmcf_task exists and its default display has an argument whose
# plugin_id is menu_children, attached to table=node field=menu_children_filter (the module's
# real Views-data key for the argument, per views_menu_children_filter.views.inc).
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("vmcf_task");
  $ok = FALSE;
  $found = "none";
  if ($v) {
    $display = $v->get("display");
    $arguments = $display["default"]["display_options"]["arguments"] ?? [];
    foreach ($arguments as $id => $arg) {
      if (($arg["plugin_id"] ?? "") === "menu_children" && ($arg["table"] ?? "") === "node" && ($arg["field"] ?? "") === "menu_children_filter") {
        $ok = TRUE;
        $found = $id;
        break;
      }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " argument=" . $found . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
