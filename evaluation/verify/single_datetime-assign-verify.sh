#!/usr/bin/env bash
# Execution VERIFY: PASS when field_sdt_task's component in
# core.entity_form_display.node.single_datetime_eval.default uses the Single DateTimePicker
# widget (type === single_date_time_widget). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.single_datetime_eval.default");
  $c = $fd ? $fd->getComponent("field_sdt_task") : NULL;
  $type = $c["type"] ?? "none";
  $ok = ($type === "single_date_time_widget");
  print ($ok ? "PASS" : "FAIL") . " widget=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
