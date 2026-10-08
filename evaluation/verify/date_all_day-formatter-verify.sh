#!/usr/bin/env bash
# Execution VERIFY: PASS when field_dad_task on node.article uses the date_all_day widget
# (daterange_all_day) on the default form display AND a date_all_day formatter
# (daterange_all_day_default or _custom) on the default view display with settings.date_only_format
# set to the html_date date format. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $w = $fd ? ($fd->getComponent("field_dad_task")["type"] ?? "none") : "none";
  $c = $vd ? $vd->getComponent("field_dad_task") : NULL;
  $f = $c["type"] ?? "none";
  $dof = $c["settings"]["date_only_format"] ?? NULL;
  $ok = ($w === "daterange_all_day")
    && in_array($f, ["daterange_all_day_default", "daterange_all_day_custom"], TRUE)
    && ($dof === "html_date");
  print ($ok ? "PASS" : "FAIL") . " widget=" . $w . " formatter=" . $f
    . " date_only_format=" . var_export($dof, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
