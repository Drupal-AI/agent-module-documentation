#!/usr/bin/env bash
# Execution VERIFY (hours_minutes_seconds): PASS when field_hms_task's component in
# core.entity_view_display.node.article.default uses the ISO 8601 formatter with visible_label TRUE.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_hms_task") : NULL;
  $type = $c["type"] ?? "none";
  $vl = $c["settings"]["visible_label"] ?? NULL;
  $ok = ($type === "hour_minutes_seconds_iso_duration_formatter" && $vl == TRUE);
  print ($ok?"PASS":"FAIL")." type=".$type." visible_label=".var_export($vl,TRUE)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
