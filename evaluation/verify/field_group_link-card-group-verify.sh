#!/usr/bin/env bash
# Execution VERIFY for "wrap field_fgl_task_body in a field_group_link group pointing at
# field_fgl_task_link, opening in a new tab".
# PASS when core.entity_view_display.node.article.fgl_task has a field_group group named
# group_fgl_task with format_type 'link', format_settings.target 'field_fgl_task_link',
# format_settings.target_attribute '_blank', and field_fgl_task_body among its children.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.fgl_task");
  $g = $vd ? $vd->getThirdPartySetting("field_group", "group_fgl_task") : NULL;
  $fmt = $g["format_type"] ?? NULL;
  $set = $g["format_settings"] ?? [];
  $children = $g["children"] ?? [];
  $ok = ($fmt === "link")
    && (($set["target"] ?? NULL) === "field_fgl_task_link")
    && (($set["target_attribute"] ?? NULL) === "_blank")
    && in_array("field_fgl_task_body", $children, TRUE);
  print ($ok ? "PASS" : "FAIL")
    . " format_type=" . var_export($fmt, TRUE)
    . " target=" . var_export($set["target"] ?? NULL, TRUE)
    . " target_attribute=" . var_export($set["target_attribute"] ?? NULL, TRUE)
    . " children=" . implode(",", $children) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
