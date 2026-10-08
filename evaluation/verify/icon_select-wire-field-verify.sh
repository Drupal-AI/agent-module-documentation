#!/usr/bin/env bash
# Execution VERIFY: PASS when field_is_task_icon on node.article uses the Icon Select widget
# (icon_select_widget_default) in the default form display AND the SVG Icon formatter
# (icon_select_formatter_default) in the default view display. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $repo = \Drupal::service("entity_display.repository");
  $w = $repo->getFormDisplay("node", "article", "default")->getComponent("field_is_task_icon");
  $f = $repo->getViewDisplay("node", "article", "default")->getComponent("field_is_task_icon");
  $wt = $w["type"] ?? "none"; $ft = $f["type"] ?? "none";
  $ok = ($wt === "icon_select_widget_default") && ($ft === "icon_select_formatter_default");
  print ($ok ? "PASS" : "FAIL") . " widget=" . $wt . " formatter=" . $ft . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
